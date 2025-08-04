import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PawPalApp/theme_provider.dart';

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
        backgroundColor: ThemeProvider.successColor,
      ));

      Navigator.pop(context);
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
        backgroundColor: ThemeProvider.errorColor,
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
    // Get theme colors
    final primaryColor = ThemeProvider.primaryColor;
    final backgroundColor = ThemeProvider.backgroundColor;
    final cardColor = ThemeProvider.cardColor;
    final textColor = ThemeProvider.textColor;
    final accentColor = ThemeProvider.accentColor;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.petId != null ? "Edit Pet" : "Add Pet",
          style: ThemeProvider.headingStyle,
        ),
        backgroundColor: primaryColor,
        elevation: 2,
      ),
      body: _isUploading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: primaryColor),
                  SizedBox(height: 20),
                  Text(
                    "Uploading... Please wait.",
                    style: ThemeProvider.bodyStyle,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ThemeProvider.shadowColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: cardColor,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : (_imageUrl != null
                                      ? NetworkImage(_imageUrl!) as ImageProvider
                                      : null),
                              child: _imageFile == null && _imageUrl == null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 36,
                                          color: accentColor,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Add Photo",
                                          style: ThemeProvider.smallStyle.copyWith(
                                            color: accentColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        if (_imageFile != null || _imageUrl != null)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ThemeProvider.cardColor,
                                  width: 2,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: ThemeProvider.lightTextColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeProvider.shadowColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pet Information",
                            style: ThemeProvider.subheadingStyle,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Pet Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.pets, color: accentColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.category_outlined, color: accentColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.cake_outlined, color: accentColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.wc_outlined, color: accentColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Male',
                                child: Row(
                                  children: [
                                    Icon(Icons.male, color: ThemeProvider.maleIconColor, size: 18),
                                    SizedBox(width: 8),
                                    Text('Male'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Female',
                                child: Row(
                                  children: [
                                    Icon(Icons.female, color: ThemeProvider.femaleIconColor, size: 18),
                                    SizedBox(width: 8),
                                    Text('Female'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Unknown',
                                child: Row(
                                  children: [
                                    Icon(Icons.help_outline, color: ThemeProvider.disabledColor, size: 18),
                                    SizedBox(width: 8),
                                    Text('Unknown'),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _sex = value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          widget.petId != null ? Icons.save : Icons.add_circle,
                          size: 24,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: ThemeProvider.lightTextColor,
                          elevation: 2,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: _uploadPet,
                        label: Text(widget.petId != null
                            ? "Update Pet Details"
                            : "Add New Pet"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
