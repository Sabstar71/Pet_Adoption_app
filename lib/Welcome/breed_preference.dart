import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PawPalApp/pawpal_widget.dart';
import 'package:PawPalApp/theme_provider.dart';

class BreedPreferencesScreen extends StatefulWidget {
  final String selectedCategory;

  const BreedPreferencesScreen({required this.selectedCategory, Key? key})
      : super(key: key);

  @override
  State<BreedPreferencesScreen> createState() => _BreedPreferencesScreenState();
}

class _BreedPreferencesScreenState extends State<BreedPreferencesScreen> {
  // Loading state
  bool _isLoading = false;
  
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
    
    // Get theme colors
    final primaryColor = ThemeProvider.primaryColor;
    final backgroundColor = ThemeProvider.backgroundColor;
    final cardColor = ThemeProvider.cardColor;
    final textColor = ThemeProvider.textColor;
    final accentColor = ThemeProvider.accentColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Breed Preferences", style: ThemeProvider.headingStyle),
        backgroundColor: primaryColor,
        elevation: 2,
        foregroundColor: ThemeProvider.lightTextColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 1,
                        color: accentColor,
                        backgroundColor: ThemeProvider.disabledColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(" 3 / 3", style: ThemeProvider.bodyStyle)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            padding: const EdgeInsets.all(16),
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
            child: Text(
              "Specify your preferences for the breed of the animal you'd like to adopt. Select all that apply.",
              style: ThemeProvider.subheadingStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
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
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? accentColor
                              : cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeProvider.shadowColor.withOpacity(isSelected ? 0.1 : 0.05),
                              blurRadius: isSelected ? 8 : 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected ? primaryColor : ThemeProvider.transparentColor,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: ThemeProvider.lightTextColor,
                                ),
                              ),
                            Text(
                              breed,
                              style: TextStyle(
                                color: isSelected ? ThemeProvider.lightTextColor : textColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
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
            child: Column(
              children: [
                if (selectedBreeds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      "${selectedBreeds.length} breed${selectedBreeds.length > 1 ? 's' : ''} selected",
                      style: ThemeProvider.smallStyle.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    // Show loading indicator
                    setState(() {
                      _isLoading = true;
                    });
                    
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("User not logged in"),
                          backgroundColor: ThemeProvider.errorColor,
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
                        backgroundColor: ThemeProvider.errorColor,
                        duration: Duration(seconds: 2),
                      ));
                    } finally {
                      // Hide loading indicator if we're still on this screen
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(ThemeProvider.lightTextColor),
                            strokeWidth: 2,
                          ),
                        )
                      : Text("Continue", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: ThemeProvider.lightTextColor,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
