import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:PawPalApp/Welcome/breed_preference.dart";

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
      appBar: AppBar(title: Text("Let's Find Your Match!")),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.7,
                    color: Colors.orange,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(" 2 / 3")
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("What type of animal are you looking to adopt?",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
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
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.orange[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              isSelected ? Colors.orange : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category['image']!,
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                          Text(category['name']!)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
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
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
