import 'package:flutter/material.dart';

/// Enhanced ThemeProvider with standardized colors and text styles
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Primary colors
  static const Color primaryAmber = Color(0xFFFFC107);
  static const Color primaryOrange = Color(0xFFFF9800);
  static const Color primaryDeepOrange = Color(0xFFFF5722);
  static Color get primaryColor => primaryAmber;
  
  // Background colors
  static const Color lightBackground = Color(0xFFFFE082);
  static const Color darkBackground = Color(0xFF1E1E1E);
  
  // Card colors
  static const Color lightCardColor = Colors.white;
  static const Color darkCardColor = Color(0xFF2C2C2C);
  
  // Text colors
  static const Color lightTextColor = Color(0xFF212121);
  static const Color darkTextColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFF757575);
  
  // Accent colors
  static const Color accentColor = Color(0xFFB26A00);
  
  // Utility colors
  static const Color errorColor = Colors.red;
  static const Color successColor = Color(0xFF388E3C); // Green[700]
  static const Color disabledColor = Colors.grey;
  static const Color shadowColor = Colors.black;
  static const Color transparentColor = Colors.transparent;
  static const Color maleIconColor = Colors.blue;
  static const Color femaleIconColor = Colors.pink;
  
  // Dynamic colors based on theme
  static Color get backgroundColor => 
      ThemeProvider().isDarkMode ? darkBackground : lightBackground;
  static Color get cardColor => 
      ThemeProvider().isDarkMode ? darkCardColor : lightCardColor;
  static Color get textColor => 
      ThemeProvider().isDarkMode ? darkTextColor : lightTextColor;
  
  // Standard text styles
  static TextStyle get headingStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ThemeProvider().isDarkMode ? darkTextColor : lightTextColor,
      );
      
  static TextStyle get subheadingStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: ThemeProvider().isDarkMode ? darkTextColor : lightTextColor,
      );
      
  static TextStyle get bodyStyle => TextStyle(
        fontSize: 16,
        color: ThemeProvider().isDarkMode ? darkTextColor : lightTextColor,
      );
      
  static TextStyle get smallStyle => TextStyle(
        fontSize: 14,
        color: secondaryTextColor,
      );

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
