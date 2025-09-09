import 'package:flutter/material.dart';

class AppColors {
  // Figma-dan alınan rənglər
  static const Color primary = Color(0xFF292526); // Dark gray
  static const Color secondary = Color(0xFF787676); // Medium gray
  static const Color tertiary = Color(0xFFA3A1A2); // Light gray
  static const Color background = Color(0xFFF2F2F2); // Very light gray/off-white
  static const Color surface = Color(0xFF121111); // Black
  
  // Əlavə rənglər
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFE53E3E);
  static const Color success = Color(0xFF38A169);
  static const Color warning = Color(0xFFD69E2E);
  static const Color info = Color(0xFF3182CE);
  
  // Gradient rənglər
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, surface],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadow rənglər
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
}
