import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'find_match.dart';
import "package:PawPalApp/Welcome/buyer/pet_dashboard.dart";
import "package:PawPalApp/theme_provider.dart";

class TellAboutScreen extends StatefulWidget {
  @override
  _TellAboutScreenState createState() => _TellAboutScreenState();
}

class _TellAboutScreenState extends State<TellAboutScreen> {
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        leading: BackButton(color: ThemeProvider.lightTextColor),
        backgroundColor: ThemeProvider.transparentColor,
        elevation: 0,
        toolbarHeight: 56,
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
                    color: ThemeProvider.primaryAmber,
                    backgroundColor: ThemeProvider.disabledColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "1 / 3",
                  style: ThemeProvider.smallStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider.lightTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Title
            Text(
              "Tell us about yourself",
              style: ThemeProvider.headingStyle,
            ),
            SizedBox(height: 12),

            // Subtitle
            Text(
              "Are you a Pet Owner or Organization ready to find loving homes? "
              "Or a Pet Adopter looking for your new best friend?",
              style: ThemeProvider.bodyStyle.copyWith(
                color: ThemeProvider.lightTextColor.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 40),

            // Pet Owner Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedRole == 'Owner' ? [
                  BoxShadow(
                    color: ThemeProvider.primaryAmber.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ] : [],
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedRole == 'Owner'
                      ? ThemeProvider.primaryAmber
                      : ThemeProvider.cardColor,
                  foregroundColor:
                      selectedRole == 'Owner' ? ThemeProvider.lightTextColor : ThemeProvider.lightTextColor,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  minimumSize: Size(double.infinity, 0),
                  side: BorderSide(
                      color:
                          selectedRole == 'Owner' ? ThemeProvider.primaryAmber : ThemeProvider.disabledColor,
                      width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => setState(() => selectedRole = 'Owner'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pets),
                    SizedBox(width: 8),
                    Text(
                      "Pet Owner or Organisation",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Pet Adopter Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: selectedRole == 'adopter' ? [
                  BoxShadow(
                    color: ThemeProvider.primaryAmber.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ] : [],
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedRole == 'adopter'
                      ? ThemeProvider.primaryAmber
                      : ThemeProvider.cardColor,
                  foregroundColor:
                      selectedRole == 'adopter' ? ThemeProvider.lightTextColor : ThemeProvider.lightTextColor,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  minimumSize: Size(double.infinity, 0),
                  side: BorderSide(
                      color: selectedRole == 'adopter'
                          ? ThemeProvider.primaryAmber
                          : ThemeProvider.disabledColor,
                      width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => setState(() => selectedRole = 'adopter'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 8),
                    Text(
                      "Pet Adopter",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Continue Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: selectedRole.isNotEmpty ? [
                  BoxShadow(
                    color: ThemeProvider.primaryAmber.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  )
                ] : [],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeProvider.primaryAmber,
                  foregroundColor: ThemeProvider.lightTextColor,
                  disabledBackgroundColor: ThemeProvider.disabledColor,
                  disabledForegroundColor: ThemeProvider.disabledColor.withOpacity(0.8),
                  minimumSize: Size(double.infinity, 56),
                  elevation: selectedRole.isNotEmpty ? 0 : 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: selectedRole.isNotEmpty
                    ? () async {
                        // Show loading indicator
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                SizedBox(
                                  width: 20, 
                                  height: 20, 
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(ThemeProvider.lightTextColor),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text("Saving your preferences..."),
                              ],
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: ThemeProvider.primaryAmber,
                          ),
                        );
                        
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
                              content: Text("Something went wrong. Please try again."),
                              backgroundColor: ThemeProvider.errorColor,
                            ),
                          );
                        }
                      }
                    : null,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
