import 'package:flutter/material.dart';

class PetDetailsScreen extends StatelessWidget {
  final String petName;
  final String petImage;
  final String petDescription;

  const PetDetailsScreen({super.key, 
    required this.petName,
    required this.petImage,
    required this.petDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(petName)),
      body: Column(
        children: [
          Image.network(
            petImage,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(petDescription, style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
