import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.background,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onTertiary: AppColors.white,
        onSurface: AppColors.primary,
        onBackground: AppColors.primary,
        onError: AppColors.white,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: AppSizes.iconM,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.encodeSansTextTheme().copyWith(
        displayLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH4,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        displayMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH3,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        displaySmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH2,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        headlineLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH1,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        headlineMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXXL,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        headlineSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        titleLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        titleMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        titleSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        bodyLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.normal,
          color: AppColors.primary,
        ),
        bodyMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.normal,
          color: AppColors.primary,
        ),
        bodySmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.normal,
          color: AppColors.secondary,
        ),
        labelLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
        labelMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
        labelSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXS,
          fontWeight: FontWeight.w500,
          color: AppColors.secondary,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingM,
        ),
        hintStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          color: AppColors.secondary,
        ),
        labelStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          color: AppColors.secondary,
        ),
        errorStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          color: AppColors.error,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        margin: const EdgeInsets.all(AppSizes.paddingS),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.tertiary,
        thickness: 1,
        space: 1,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primary,
        size: AppSizes.iconM,
      ),
      
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.white,
        size: AppSizes.iconM,
      ),
      
      // Scaffold Background Color
      scaffoldBackgroundColor: AppColors.background,
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.tertiary,
        circularTrackColor: AppColors.tertiary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        background: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onTertiary: AppColors.white,
        onSurface: AppColors.white,
        onBackground: AppColors.white,
        onError: AppColors.white,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
          size: AppSizes.iconM,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.encodeSansTextTheme().copyWith(
        displayLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH4,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        displayMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH3,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        displaySmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH2,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        headlineLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeH1,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        headlineMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXXL,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        headlineSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        bodyLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeL,
          fontWeight: FontWeight.normal,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.normal,
          color: AppColors.white,
        ),
        bodySmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.normal,
          color: AppColors.tertiary,
        ),
        labelLarge: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        labelMedium: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        labelSmall: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeXS,
          fontWeight: FontWeight.w500,
          color: AppColors.tertiary,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightM),
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          textStyle: GoogleFonts.encodeSans(
            fontSize: AppSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingM,
        ),
        hintStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          color: AppColors.tertiary,
        ),
        labelStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeM,
          color: AppColors.tertiary,
        ),
        errorStyle: GoogleFonts.encodeSans(
          fontSize: AppSizes.fontSizeS,
          color: AppColors.error,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        margin: const EdgeInsets.all(AppSizes.paddingS),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.tertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.tertiary,
        thickness: 1,
        space: 1,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: AppSizes.iconM,
      ),
      
      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.white,
        size: AppSizes.iconM,
      ),
      
      // Scaffold Background Color
      scaffoldBackgroundColor: AppColors.surface,
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.white,
        linearTrackColor: AppColors.tertiary,
        circularTrackColor: AppColors.tertiary,
      ),
    );
  }
}
