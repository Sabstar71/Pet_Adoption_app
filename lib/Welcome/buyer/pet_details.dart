import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_pet.dart'; // Import AddPet

class PetDetails extends StatelessWidget {
  final String petId;
  final Map<String, dynamic> petData;

  PetDetails({required this.petId, required this.petData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(petData['name'] ?? "Pet Details"),
        actions: [
          IconButton(
            // Added Delete button in AppBar
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context); // Show confirmation
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          // Added Card for better UI
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: petData['imageUrl'] != null &&
                          petData['imageUrl'].toString().isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            petData['imageUrl'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          //show a placeholder
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.image,
                              size: 100, color: Colors.grey[400]),
                        ),
                ),
                SizedBox(height: 20),
                _buildDetailRow(
                    "Name", petData['name'] ?? 'N/A'), // Extracted method
                _buildDetailRow("Breed", petData['breed'] ?? 'N/A'),
                _buildDetailRow("Age", petData['age'] ?? 'N/A'),
                _buildDetailRow("Sex", petData['sex'] ?? 'N/A'),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Edit Pet"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddPet(
                            petId: petId,
                            existingData: petData,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      //Added style
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Extracted widget for consistent styling
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label + ":",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog before deleting
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Pet"),
          content: Text("Are you sure you want to delete this pet?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _deletePet(context); // Call delete function
              },
              child: Text("Delete"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, //make the delete button red
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the pet from Firestore
  void _deletePet(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('pets').doc(petId).delete();
      Navigator.of(context).pop(); // Dismiss the dialog
      Navigator.of(context).pop(); // Go back to the previous screen (dashboard)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pet deleted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error deleting pet: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete pet: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
