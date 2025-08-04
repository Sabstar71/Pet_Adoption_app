import "package:flutter/material.dart";
import "package:PawPalApp/theme_provider.dart";

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryAmber.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pets,
                  size: 70,
                  color: ThemeProvider.primaryAmber,
                ),
              ),
              const SizedBox(height: 24),
              
              // App name
              Text(
                "PawPal",
                style: ThemeProvider.headingStyle.copyWith(
                  color: ThemeProvider.primaryAmber,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Find your perfect companion",
                style: ThemeProvider.subheadingStyle.copyWith(
                  color: ThemeProvider.lightTextColor,
                ),
              ),
              const SizedBox(height: 40),
              
              // Loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ThemeProvider.primaryAmber),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
