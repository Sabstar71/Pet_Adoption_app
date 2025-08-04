import 'package:PawPalApp/Authentication/splash.dart';
import 'package:PawPalApp/Welcome/tell_about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:PawPalApp/Authentication/auth.dart';
import 'package:PawPalApp/pawpal_widget.dart';
import "package:PawPalApp/Welcome/breed_preference.dart";
import "package:PawPalApp/Welcome/welcome.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // ✅ Added

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PawPal - Pet Adoption",
      themeMode: themeProvider.themeMode,
      // Light theme definition
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(ThemeProvider.primaryAmber.value, <int, Color>{
          50: ThemeProvider.primaryAmber.withOpacity(0.1),
          100: ThemeProvider.primaryAmber.withOpacity(0.2),
          200: ThemeProvider.primaryAmber.withOpacity(0.3),
          300: ThemeProvider.primaryAmber.withOpacity(0.4),
          400: ThemeProvider.primaryAmber.withOpacity(0.5),
          500: ThemeProvider.primaryAmber,
          600: ThemeProvider.primaryAmber.withOpacity(0.7),
          700: ThemeProvider.primaryAmber.withOpacity(0.8),
          800: ThemeProvider.primaryAmber.withOpacity(0.9),
          900: ThemeProvider.primaryAmber,
        }),
        scaffoldBackgroundColor: ThemeProvider.lightBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeProvider.primaryAmber,
          foregroundColor: ThemeProvider.lightTextColor,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        cardColor: ThemeProvider.lightCardColor,
        textTheme: TextTheme(
          headlineLarge: ThemeProvider.headingStyle,
          headlineMedium: ThemeProvider.subheadingStyle,
          bodyLarge: ThemeProvider.bodyStyle,
          bodyMedium: ThemeProvider.smallStyle,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ThemeProvider.cardColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.disabledColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.errorColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeProvider.primaryAmber,
            foregroundColor: ThemeProvider.lightTextColor,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ThemeProvider.accentColor,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: ThemeProvider.primaryAmber,
            side: BorderSide(color: ThemeProvider.primaryAmber),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: ThemeProvider.primaryAmber,
          secondary: ThemeProvider.primaryOrange,
          onPrimary: ThemeProvider.lightTextColor,
          onSecondary: ThemeProvider.lightTextColor,
          surface: ThemeProvider.lightCardColor,
          onSurface: ThemeProvider.lightTextColor,
        ),
      ),
      // Dark theme definition
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ThemeProvider.darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeProvider.primaryAmber.withOpacity(0.8),
          foregroundColor: ThemeProvider.lightTextColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        cardColor: ThemeProvider.darkCardColor,
        textTheme: TextTheme(
          headlineLarge: ThemeProvider.headingStyle,
          headlineMedium: ThemeProvider.subheadingStyle,
          bodyLarge: ThemeProvider.bodyStyle,
          bodyMedium: ThemeProvider.smallStyle,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ThemeProvider.darkCardColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.disabledColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeProvider.errorColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeProvider.primaryAmber,
            foregroundColor: ThemeProvider.lightTextColor,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ThemeProvider.primaryAmber,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: ThemeProvider.primaryAmber,
            side: BorderSide(color: ThemeProvider.primaryAmber),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: ThemeProvider.primaryAmber,
          secondary: ThemeProvider.primaryOrange,
          onPrimary: ThemeProvider.lightTextColor,
          onSecondary: ThemeProvider.lightTextColor,
          surface: ThemeProvider.darkCardColor,
          onSurface: ThemeProvider.darkTextColor,
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return splashScreen();
          }
          if (snapshot.hasData) {
            return MyHomePage();
          }
          return Auth();
        },
      ),
    );
  }
}
