import 'package:PawPalApp/Authentication/splash.dart';
import 'package:PawPalApp/Welcome/tell_about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart'; // ✅ Added for ThemeProvider
import 'theme_provider.dart'; // ✅ Ensure this file defines ThemeProvider
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
      title: "Chat APP",
      themeMode: themeProvider.themeMode, // ✅ Uses theme provider
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFFFE082), // Warm light yellow
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFC107), // Warm golden yellow
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC107), // Warm amber
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFB26A00), // Deep warm brown
          ),
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
