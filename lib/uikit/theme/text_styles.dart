import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class AppTextStyles {
  // Headline Styles
  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.2,
  );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.2,
  );

  static TextStyle headlineSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.3,
  );

  // Title Styles
  static TextStyle titleLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.3,
  );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.3,
  );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.4,
  );

  // Body Styles
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    height: 1.4,
  );

  // Label Styles
  static TextStyle labelLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.4,
  );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.4,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    height: 1.3,
  );
}
