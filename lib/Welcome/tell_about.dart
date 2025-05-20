import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'find_match.dart';

import "package:PawPalApp/Welcome/buyer/pet_dashboard.dart";

class TellAboutScreen extends StatefulWidget {
  @override
  _TellAboutScreenState createState() => _TellAboutScreenState();
}

class _TellAboutScreenState extends State<TellAboutScreen> {
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.35,
                    color: Colors.orange,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(width: 8),
                Text("1 / 3"),
              ],
            ),
            SizedBox(height: 32),

            // Title
            Text(
              "Tell us about yourself",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Subtitle
            Text(
              "Are you a Pet Owner or Organization ready to find loving homes? "
              "Or a Pet Adopter looking for your new best friend?",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 40),

            // Pet Owner Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedRole == 'Owner'
                    ? Colors.orange
                    : Colors.transparent,
                foregroundColor:
                    selectedRole == 'Owner' ? Colors.white : Colors.black,
                padding: EdgeInsets.symmetric(vertical: 18),
                minimumSize: Size(double.infinity, 0),
                side: BorderSide(
                    color:
                        selectedRole == 'Owner' ? Colors.orange : Colors.grey),
              ),
              onPressed: () => setState(() => selectedRole = 'Owner'),
              child: Text("Pet Owner or Organisation"),
            ),

            SizedBox(height: 16),

            // Pet Adopter Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedRole == 'adopter'
                    ? Colors.orange
                    : Colors.transparent,
                foregroundColor:
                    selectedRole == 'adopter' ? Colors.white : Colors.black,
                padding: EdgeInsets.symmetric(vertical: 18),
                minimumSize: Size(double.infinity, 0),
                side: BorderSide(
                    color: selectedRole == 'adopter'
                        ? Colors.orange
                        : Colors.grey),
              ),
              onPressed: () => setState(() => selectedRole = 'adopter'),
              child: Text("Pet Adopter"),
            ),

            Spacer(),

            // Continue Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: selectedRole.isNotEmpty
                  ? () async {
                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            'userType': selectedRole,
                            'email': user.email,
                            'createdAt': Timestamp.now(),
                          }, SetOptions(merge: true));
                          if (selectedRole == 'adopter') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindYourMatchScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PetDashboard()));
                          }
                        }
                      } catch (e) {
                        print("Error saving userType: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Something went wrong. Please try again.")),
                        );
                      }
                    }
                  : null,
              child: Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
