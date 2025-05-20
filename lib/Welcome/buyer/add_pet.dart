import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPet extends StatefulWidget {
  final String? petId;
  final Map<String, dynamic>? existingData;

  AddPet({this.petId, this.existingData});

  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _sex = 'Male';
  bool _isUploading = false;

  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      _nameController.text = widget.existingData!['name'] ?? '';
      _breedController.text = widget.existingData!['breed'] ?? '';
      _ageController.text = widget.existingData!['age']?.toString() ?? '';
      _sex = widget.existingData!['sex'] ?? 'Male';
      _imageUrl = widget.existingData!['imageUrl'];
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(String petId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('pet_images/$petId.jpg');
      await storageRef.putFile(_imageFile!);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  Future<void> _uploadPet() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final petDocumentId = widget.petId ??
          FirebaseFirestore.instance.collection('pets').doc().id;

      // Upload image if a new one is selected
      if (_imageFile != null) {
        _imageUrl = await _uploadImage(petDocumentId);
      }

      final userId = FirebaseAuth.instance.currentUser!.uid;

      final petData = {
        'name': _nameController.text.trim(),
        'breed': _breedController.text.trim(),
        'age': _ageController.text.trim(),
        'sex': _sex,
        'imageUrl': _imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'ownerId': userId, // 🔐 Link pet to the user
      };

      final petDoc =
          FirebaseFirestore.instance.collection('pets').doc(petDocumentId);

      if (widget.petId != null) {
        await petDoc.update(petData);
      } else {
        await petDoc.set(petData);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.petId != null
            ? "Pet updated successfully!"
            : "Pet added successfully!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pop(context);
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.petId != null ? "Edit Pet" : "Add Pet")),
      body: _isUploading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Uploading... Please wait.",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (_imageUrl != null
                                ? NetworkImage(_imageUrl!) as ImageProvider
                                : AssetImage('assets/pet_placeholder.png')),
                        child: _imageFile == null && _imageUrl == null
                            ? Icon(Icons.add_a_photo, size: 30)
                            : null,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Pet Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.pets),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter pet name'
                          : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _breedController,
                      decoration: InputDecoration(
                        labelText: 'Breed',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter breed'
                          : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age (e.g., 2, 0.5 for 6 months)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }
                        final age = double.tryParse(value);
                        if (age == null || age < 0) {
                          return 'Please enter a valid age';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _sex,
                      decoration: InputDecoration(
                        labelText: 'Sex',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.wc_outlined),
                      ),
                      items: ['Male', 'Female', 'Unknown']
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _sex = value);
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: Icon(
                          widget.petId != null ? Icons.save : Icons.add_circle),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: _uploadPet,
                      label: Text(widget.petId != null
                          ? "Update Pet Details"
                          : "Add New Pet"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
