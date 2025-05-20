import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_pet.dart'; // AddPet screen
import 'pet_details.dart'; // PetDetails screen

class PetDashboard extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Listed Pets")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pets')
            .where('ownerId', isEqualTo: userId) // ✅ Filter by logged-in user
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No pets listed yet."));
          }

          final pets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              var pet = pets[index];
              String petName = pet['name'] ?? 'Unnamed Pet';
              String petBreed = pet['breed'] ?? 'Unknown Breed';
              String petSex = pet['sex'] ?? 'Unknown Sex';

              return ListTile(
                leading: Icon(Icons.pets, size: 40),
                title: Text(petName),
                subtitle: Text('$petBreed, Sex: $petSex'),
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPet())),
        child: Icon(Icons.add),
      ),
    );
  }
}
