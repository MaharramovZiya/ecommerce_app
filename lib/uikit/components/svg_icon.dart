import 'package:ecommerce_apps/core/constants/app_colors.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.icon, {
      this.color,
      this.useDefaultColor = false,
      this.size = 20,
      super.key,
    }): height = null, width = null;

  const SvgIcon.dimensions(
    this.icon, {
        this.color,
        this.useDefaultColor = false,
        required this.height,
        required this.width,
        super.key,
      }
    ): size = null;

  const SvgIcon.full(
    this.icon, {
        this.color,
        this.useDefaultColor = false,
        super.key,
      }
    ): size = double.maxFinite, height = null, width = null;

  final AppsIcons icon;
  final Color? color;
  final bool useDefaultColor;
  final double? size;
  final double? height; 
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SvgPicture.asset(
      icon.path,
      height: size ?? height,
      width: size ?? width,
      colorFilter: !useDefaultColor ? ColorFilter.mode(color ?? theme.colorScheme.onSurface, BlendMode.srcIn) : null, 
    );
  }
}