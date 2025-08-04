import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import "package:PawPalApp/Chat/chatH.dart";
import "package:PawPalApp/Chat/usertile.dart";

import 'home_screen.dart';
import 'adoption_form_screen.dart';
import 'profile_screen.dart';

class PawPalAppWidget extends StatelessWidget {
  const PawPalAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawPal',
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
            borderSide: BorderSide(color: ThemeProvider.errorColor.withOpacity(0.7)),
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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Move widgetOptions here
    final List<Widget> _widgetOptions = <Widget>[
      const HomeScreen(),
      const AdoptionFormScreen(),
      UserListPage(), // Now works correctly
      const ProfileScreen(),
    ];

    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Adopt'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ThemeProvider.lightTextColor,
        unselectedItemColor: ThemeProvider.lightTextColor.withOpacity(0.7),
        backgroundColor: ThemeProvider.primaryAmber,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
