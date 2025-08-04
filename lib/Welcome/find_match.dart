import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:PawPalApp/Welcome/breed_preference.dart";
import "package:PawPalApp/theme_provider.dart";

class FindYourMatchScreen extends StatefulWidget {
  @override
  _FindYourMatchScreenState createState() => _FindYourMatchScreenState();
}

class _FindYourMatchScreenState extends State<FindYourMatchScreen> {
  final List<Map<String, String>> categories = [
    {'name': 'Dogs', 'image': 'assets/dog.png'},
    {'name': 'Cats', 'image': 'assets/cat.png'},
    {'name': 'Birds', 'image': 'assets/birds.png'},
    {'name': 'Others', 'image': 'assets/fish.png'}
  ];

  String selectedCategory = 'Cats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        title: Text(
          "Let's Find Your Match!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: ThemeProvider.primaryAmber,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.7,
                      color: ThemeProvider.primaryAmber,
                      backgroundColor: ThemeProvider.disabledColor,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "2 / 3",
                    style: ThemeProvider.smallStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ThemeProvider.lightTextColor,
                    ),
                  )
                ],
              ),
            ),
            
            // Title
            Text(
              "What type of pet are you looking for?",
              style: ThemeProvider.subheadingStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            
            // Subtitle
            Text(
              "Select the type of animal you're interested in adopting.",
              style: ThemeProvider.bodyStyle.copyWith(
                color: ThemeProvider.lightTextColor.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 24),
            
            // Grid of categories
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['name']!;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? ThemeProvider.primaryAmber.withOpacity(0.15) 
                            : ThemeProvider.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected 
                              ? ThemeProvider.primaryAmber 
                              : ThemeProvider.disabledColor,
                          width: 2,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: ThemeProvider.primaryAmber.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ] : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category['image']!,
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(height: 16),
                          Text(
                            category['name']!,
                            style: ThemeProvider.bodyStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? ThemeProvider.primaryAmber 
                                  : ThemeProvider.lightTextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Continue button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 16, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeProvider.primaryAmber.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
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
                  
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .update({
                  'preferences.animalType': selectedCategory,
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BreedPreferencesScreen(
                          selectedCategory: selectedCategory),
                    ));
              },
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeProvider.primaryAmber,
                foregroundColor: ThemeProvider.lightTextColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
