import 'package:flutter/material.dart';

class Colorconstaints {
  static const Color primaryColor = Color.fromARGB(255, 43, 78, 154); 
  static const Color secondaryColor = Color.fromARGB(255, 236, 194, 66); 
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF1C2C5B);
  static const Color subtextColor = Colors.grey; 
  static const Color successColor = Colors.green; 
  static const Color errorColor = Colors.red; 
  static const Color tdcolor = Color.fromARGB(255, 229, 223, 223);
  
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(color: backgroundColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: subtextColor, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
     
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor:primaryColor,
      scaffoldBackgroundColor: Colors.black87,
      cardColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          color: backgroundColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color:backgroundColor, fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color:tdcolor, fontSize: 16),
        
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
    );
  }
}

