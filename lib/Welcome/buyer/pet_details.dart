import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_pet.dart'; // Import AddPet
import '../../../theme_provider.dart'; // Import ThemeProvider

class PetDetails extends StatelessWidget {
  final String petId;
  final Map<String, dynamic> petData;

  PetDetails({required this.petId, required this.petData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        backgroundColor: ThemeProvider.primaryAmber,
        foregroundColor: ThemeProvider.lightTextColor,
        elevation: 0,
        title: Text(
          petData['name'] ?? "Pet Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeProvider.lightTextColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: ThemeProvider.errorColor),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeProvider.lightBackground, ThemeProvider.cardColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shadowColor: ThemeProvider.shadowColor.withOpacity(0.26),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'pet-${petId}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeProvider.shadowColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: petData['imageUrl'] != null &&
                              petData['imageUrl'].toString().isNotEmpty
                          ? Image.network(
                              petData['imageUrl'],
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 250,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ThemeProvider.disabledColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ThemeProvider.primaryAmber,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 250,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ThemeProvider.disabledColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline, size: 50, color: ThemeProvider.errorColor),
                                      SizedBox(height: 10),
                                      Text('Failed to load image', style: ThemeProvider.smallStyle),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ThemeProvider.disabledColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.pets, size: 80, color: ThemeProvider.primaryAmber.withOpacity(0.5)),
                                  SizedBox(height: 10),
                                  Text('No image available', style: ThemeProvider.smallStyle),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeProvider.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeProvider.shadowColor.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow("Name", petData['name'] ?? 'N/A', Icons.pets),
                      Divider(height: 24, thickness: 0.5),
                      _buildDetailRow("Breed", petData['breed'] ?? 'N/A', Icons.category),
                      Divider(height: 24, thickness: 0.5),
                      _buildDetailRow("Age", petData['age'] ?? 'N/A', Icons.cake),
                      Divider(height: 24, thickness: 0.5),
                      _buildDetailRow(
                        "Sex", 
                        petData['sex'] ?? 'N/A', 
                        petData['sex'] == 'Male' 
                            ? Icons.male 
                            : petData['sex'] == 'Female' 
                                ? Icons.female 
                                : Icons.help_outline
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
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
                      backgroundColor: ThemeProvider.primaryAmber,
                      foregroundColor: ThemeProvider.lightTextColor,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: ThemeProvider.primaryAmber.withOpacity(0.5),
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

  // Enhanced detail row with icons and improved styling
  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ThemeProvider.primaryAmber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: ThemeProvider.primaryAmber, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeProvider.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider.lightTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced confirmation dialog with improved styling
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: ThemeProvider.errorColor, size: 28),
              SizedBox(width: 10),
              Text(
                "Delete Pet",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to delete this pet? This action cannot be undone.",
            style: ThemeProvider.bodyStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: ThemeProvider.secondaryTextColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _deletePet(context); // Call delete function
              },
              child: Text(
                "Delete",
                style: TextStyle(color: ThemeProvider.lightTextColor, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeProvider.errorColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        );
      },
    );
  }

  // Enhanced delete function with improved error handling and feedback
  void _deletePet(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: ThemeProvider.primaryAmber),
              SizedBox(width: 20),
              Text("Deleting...", style: ThemeProvider.bodyStyle),
            ],
          ),
        );
      },
    );
    
    try {
      await FirebaseFirestore.instance.collection('pets').doc(petId).delete();
      Navigator.of(context).pop(); // Dismiss the loading dialog
      Navigator.of(context).pop(); // Dismiss the confirmation dialog
      Navigator.of(context).pop(); // Go back to the previous screen (dashboard)
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: ThemeProvider.lightTextColor),
              SizedBox(width: 10),
              Text("Pet deleted successfully!"),
            ],
          ),
          backgroundColor: ThemeProvider.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      print("Error deleting pet: $e");
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: ThemeProvider.lightTextColor),
              SizedBox(width: 10),
              Expanded(child: Text("Failed to delete pet: ${e.toString()}"));
            ],
          ),
          backgroundColor: ThemeProvider.errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
