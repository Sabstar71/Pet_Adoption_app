import 'package:flutter/material.dart';
import 'theme_provider.dart';

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
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        backgroundColor: ThemeProvider.primaryAmber,
        foregroundColor: ThemeProvider.lightTextColor,
        elevation: 0,
        title: Text(
          petName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeProvider.lightTextColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: ThemeProvider.lightTextColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to favorites!'),
                  backgroundColor: ThemeProvider.accentColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image with loading indicator
            Hero(
              tag: 'pet-image-$petName',
              child: Container(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.network(
                      petImage,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: ThemeProvider.lightBackground.withOpacity(0.7),
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
                          color: ThemeProvider.lightBackground.withOpacity(0.7),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline, size: 50, color: ThemeProvider.errorColor),
                                SizedBox(height: 10),
                                Text('Failed to load image', style: ThemeProvider.smallStyle),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Gradient overlay for better text visibility
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              ThemeProvider.lightTextColor.withOpacity(0.7),
                              ThemeProvider.transparentColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Pet name overlay
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        petName,
                        style: TextStyle(
                          color: ThemeProvider.lightCardColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: ThemeProvider.lightTextColor.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Pet description card
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ThemeProvider.lightCardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeProvider.lightTextColor.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeProvider.lightTextColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    petDescription,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ThemeProvider.lightTextColor,
                    ),
                  ),
                ],
              ),
            ),
            // Adoption button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.pets),
                label: Text('Adopt Me'),
                onPressed: () {
                  // Navigate to adoption form
                  Navigator.pushNamed(context, '/adoption_form', arguments: {
                    'petName': petName,
                    'petImage': petImage,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeProvider.primaryAmber,
                  foregroundColor: ThemeProvider.lightTextColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  shadowColor: ThemeProvider.primaryAmber.withOpacity(0.5),
                ),
              ),
            ),
            // Contact button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: Icon(Icons.message),
                label: Text('Contact Shelter'),
                onPressed: () {
                  // Navigate to chat screen
                  Navigator.pushNamed(context, '/chat');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: ThemeProvider.accentColor,
                  side: BorderSide(color: ThemeProvider.accentColor),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
