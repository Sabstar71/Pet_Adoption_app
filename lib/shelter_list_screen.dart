import 'package:flutter/material.dart';

class ShelterListScreen extends StatelessWidget {
  const ShelterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shelters Near You")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.store),
            title: Text("Happy Paws Shelter"),
            subtitle: Text("123 Pet Street, Lahore"),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text("Rescue Center"),
            subtitle: Text("456 Adoption Road, Lahore"),
          ),
        ],
      ),
    );
  }
}
