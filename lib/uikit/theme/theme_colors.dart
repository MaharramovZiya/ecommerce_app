import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ThemeColors {
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surface,
    onSurface: AppColors.primary,
    surfaceVariant: AppColors.background,
    onSurfaceVariant: AppColors.secondary,
    background: AppColors.background,
    onBackground: AppColors.primary,
    outline: AppColors.secondary,
    shadow: AppColors.shadow,
  );

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surface,
    onSurface: AppColors.white,
    surfaceVariant: AppColors.background,
    onSurfaceVariant: AppColors.secondary,
    background: AppColors.background,
    onBackground: AppColors.white,
    outline: AppColors.secondary,
    shadow: AppColors.shadow,
  );
}
