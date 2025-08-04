import 'package:flutter/material.dart';
import 'tell_about.dart';
import "../pawpal_widget.dart";
import "../theme_provider.dart";

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryAmber.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryOrange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            Column(
              children: [
                // App bar with skip button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PawPalAppWidget()),
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: ThemeProvider.accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Logo and title
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        'PawPal',
                        style: ThemeProvider.headingStyle.copyWith(
                          color: ThemeProvider.primaryAmber,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Find your perfect companion',
                        style: ThemeProvider.subheadingStyle.copyWith(
                          color: ThemeProvider.lightTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Dog image centered
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/Wel.png',
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Bottom text and button
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ready to make a new friend?',
                        textAlign: TextAlign.center,
                        style: ThemeProvider.subheadingStyle.copyWith(
                          color: ThemeProvider.lightTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select your preferences and find pets near you.',
                        textAlign: TextAlign.center,
                        style: ThemeProvider.bodyStyle.copyWith(
                          color: ThemeProvider.lightTextColor.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TellAboutScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeProvider.primaryAmber,
                            foregroundColor: ThemeProvider.lightTextColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

