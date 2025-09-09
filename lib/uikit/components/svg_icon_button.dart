import 'package:ecommerce_apps/uikit/components/export.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';
import 'package:flutter/material.dart';

class SvgIconButton extends StatelessWidget {
  final AppsIcons icon;
  final Color? color;
  final VoidCallback? onTap;
  final String? label;
  final double? spacing;
  final bool useDefaultColor;
  final double? size;

  const SvgIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.label,
    this.spacing,
    this.useDefaultColor = false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = SvgIcon(
      icon,
      useDefaultColor: useDefaultColor,
      color: color,
      size: size,
    );

    if (label != null) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(width: spacing ?? 8),
              Text(
                label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: iconWidget,
      ),
    );
  }
}
