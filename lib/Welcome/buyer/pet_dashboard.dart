import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PawPalApp/theme_provider.dart';

import 'add_pet.dart'; // AddPet screen
import 'pet_details.dart'; // PetDetails screen

class PetDashboard extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

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
        title: Text("Your Listed Pets", style: ThemeProvider.headingStyle),
        backgroundColor: primaryColor,
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pets')
            .where('ownerId', isEqualTo: userId) // ✅ Filter by logged-in user
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: ThemeProvider.errorColor),
                  SizedBox(height: 16),
                  Text(
                    "Error loading pets",
                    style: ThemeProvider.subheadingStyle,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${snapshot.error}",
                    style: ThemeProvider.smallStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 80, color: ThemeProvider.disabledColor.withOpacity(0.4)),
                  SizedBox(height: 16),
                  Text(
                    "No pets listed yet",
                    style: ThemeProvider.subheadingStyle,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Add your first pet using the button below",
                    style: ThemeProvider.bodyStyle,
                  ),
                ],
              ),
            );
          }

          final pets = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                var pet = pets[index];
                String petName = pet['name'] ?? 'Unnamed Pet';
                String petBreed = pet['breed'] ?? 'Unknown Breed';
                String petSex = pet['sex'] ?? 'Unknown Sex';
                String petAge = pet['age'] ?? 'Unknown Age';
                String petCategory = pet['category'] ?? 'Unknown';
                
                // Get pet image if available
                String? imageUrl = pet['imageUrl'];

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetDetails(
                            petId: pet.id,
                            petData: pet.data() as Map<String, dynamic>,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Pet image or icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: imageUrl != null && imageUrl.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(
                                        Icons.pets,
                                        size: 40,
                                        color: accentColor,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    petCategory == 'Cats' ? Icons.pets : 
                                    petCategory == 'Dogs' ? Icons.pets : 
                                    petCategory == 'Birds' ? Icons.flutter_dash : 
                                    Icons.pets,
                                    size: 40,
                                    color: accentColor,
                                  ),
                          ),
                          SizedBox(width: 16),
                          // Pet info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  petName,
                                  style: ThemeProvider.subheadingStyle,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '$petBreed • $petAge',
                                  style: ThemeProvider.bodyStyle,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(petSex == 'Male' ? Icons.male : Icons.female, 
                                         size: 16, 
                                         color: petSex == 'Male' ? ThemeProvider.maleIconColor : ThemeProvider.femaleIconColor),
                                    SizedBox(width: 4),
                                    Text(
                                      petSex,
                                      style: ThemeProvider.smallStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Arrow icon
                          Icon(Icons.arrow_forward_ios, size: 16, color: ThemeProvider.disabledColor),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPet())),
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        elevation: 4,
      ),
    );
  }
}
