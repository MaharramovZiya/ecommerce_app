import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  outline,
  text,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool enabled;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;

  const CustomButton(
    this.text, {
    super.key,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = enabled && !isLoading && onPressed != null;

    // Size configurations
    final sizeConfig = _getSizeConfig(size);
    
    // Color configurations
    final colors = _getColors(theme, type, isEnabled);

    return SizedBox(
      width: width,
      height: height ?? sizeConfig.height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.backgroundColor,
          foregroundColor: textColor ?? colors.textColor,
          elevation: type == ButtonType.primary ? 2 : 0,
          shadowColor: type == ButtonType.primary ? colors.backgroundColor : null,
          side: type == ButtonType.outline
              ? BorderSide(
                  color: borderColor ?? colors.borderColor,
                  width: 1,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizeConfig.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: sizeConfig.horizontalPadding,
            vertical: sizeConfig.verticalPadding,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: sizeConfig.iconSize,
                height: sizeConfig.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? colors.textColor,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: sizeConfig.iconSpacing),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: sizeConfig.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _SizeConfig _getSizeConfig(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return _SizeConfig(
          height: 32,
          horizontalPadding: 12,
          verticalPadding: 6,
          fontSize: 12,
          borderRadius: 6,
          iconSize: 16,
          iconSpacing: 6,
        );
      case ButtonSize.medium:
        return _SizeConfig(
          height: 44,
          horizontalPadding: 16,
          verticalPadding: 12,
          fontSize: 14,
          borderRadius: 8,
          iconSize: 20,
          iconSpacing: 8,
        );
      case ButtonSize.large:
        return _SizeConfig(
          height: 52,
          horizontalPadding: 20,
          verticalPadding: 16,
          fontSize: 16,
          borderRadius: 10,
          iconSize: 24,
          iconSpacing: 10,
        );
    }
  }

  _ColorConfig _getColors(ThemeData theme, ButtonType type, bool isEnabled) {
    final primaryColor = theme.colorScheme.primary;
    final onSurfaceColor = theme.colorScheme.onSurface;
    final outlineColor = theme.colorScheme.outline;

    if (!isEnabled) {
      return _ColorConfig(
        backgroundColor: outlineColor.withOpacity(0.12),
        textColor: onSurfaceColor.withOpacity(0.38),
        borderColor: outlineColor.withOpacity(0.12),
      );
    }

    switch (type) {
      case ButtonType.primary:
        return _ColorConfig(
          backgroundColor: primaryColor,
          textColor: theme.colorScheme.onPrimary,
          borderColor: primaryColor,
        );
      case ButtonType.secondary:
        return _ColorConfig(
          backgroundColor: primaryColor.withOpacity(0.1),
          textColor: primaryColor,
          borderColor: primaryColor.withOpacity(0.1),
        );
      case ButtonType.outline:
        return _ColorConfig(
          backgroundColor: Colors.transparent,
          textColor: primaryColor,
          borderColor: primaryColor,
        );
      case ButtonType.text:
        return _ColorConfig(
          backgroundColor: Colors.transparent,
          textColor: primaryColor,
          borderColor: Colors.transparent,
        );
    }
  }
}

class _SizeConfig {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double borderRadius;
  final double iconSize;
  final double iconSpacing;

  _SizeConfig({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.fontSize,
    required this.borderRadius,
    required this.iconSize,
    required this.iconSpacing,
  });
}

class _ColorConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  _ColorConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });
}
