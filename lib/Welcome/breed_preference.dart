import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PawPalApp/pawpal_widget.dart';

class BreedPreferencesScreen extends StatefulWidget {
  final String selectedCategory;

  const BreedPreferencesScreen({required this.selectedCategory, Key? key})
      : super(key: key);

  @override
  State<BreedPreferencesScreen> createState() => _BreedPreferencesScreenState();
}

class _BreedPreferencesScreenState extends State<BreedPreferencesScreen> {
  // Breed data based on animal
  final Map<String, List<String>> breedOptions = {
    'Cats': [
      'Persian',
      'Maine Coon',
      'Siamese',
      'Ragdoll',
      'Bengal',
      'Sphynx',
      'Scottish Fold',
      'Abyssinian',
      'Birman',
      'Russian Blue',
      'Siberian',
      'British Shorthair',
      'Exotic Shorthair',
      'Turkish Angora',
      'Manx',
      'Himalayan',
      'Devon Rex',
    ],
    'Dogs': [
      'Labrador',
      'German Shepherd',
      'Golden Retriever',
      'Bulldog',
      'Poodle',
      'Beagle',
      'Rottweiler',
      'Dachshund',
    ],
    // Add more if needed
  };

  final List<String> selectedBreeds = [];

  @override
  Widget build(BuildContext context) {
    final category = widget.selectedCategory;
    final breeds = breedOptions[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Breed Preferences"),
        backgroundColor: const Color.fromARGB(255, 244, 210, 18),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1,
                    color: Colors.orange,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(" 3 / 3")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Text(
              "Specify your preferences for the breed of the animal you'd like to adopt. Select all that apply.",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: breeds.map((breed) {
                    final isSelected = selectedBreeds.contains(breed);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected
                              ? selectedBreeds.remove(breed)
                              : selectedBreeds.add(breed);
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.orange[300]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          breed,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("User not logged in"),
                    ));
                    return;
                  }

                  // Save preferences
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set({
                    "category_preference": widget.selectedCategory,
                    "breed_preference": selectedBreeds,
                  }, SetOptions(merge: true));

                  // Navigate to the next screen AFTER saving
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PawPalAppWidget()),
                  );
                } catch (e) {
                  print("Error Saving Preferences: $e");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Error saving the data"),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
