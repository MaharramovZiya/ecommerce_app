import 'package:ecommerce_apps/core/constants/app_colors.dart';
import 'package:ecommerce_apps/uikit/components/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_apps/uikit/components/svg_icon_button.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? userName;
  final String? userImageUrl;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final bool isHomeStyle;

  const CustomAppBar({
    super.key,
    this.title,
    this.userName,
    this.userImageUrl,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.bottom,
    this.isHomeStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (isHomeStyle) {
      return _buildHomeStyleAppBar(context);
    }
    
    return AppBar(
      title: title != null ? Text(
        title!,
        style: TextStyle(
          color: foregroundColor ?? theme.colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ) : null,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget _buildHomeStyleAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol tərəf - Welcome message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hello, Welcome 👋',
                  style: TextStyle(
                    fontSize: 14,
                    color: foregroundColor ?? theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userName ?? 'User',
                  style: TextStyle(
                    fontSize: 20,
                    color: foregroundColor ?? theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Sağ tərəf - Actions və User profile image
          Row(
            children: [
              // Actions
              if (actions != null) ...actions!,
              
              // User profile image
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: userImageUrl != null
                      ? Image.network(
                          userImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultAvatar();
                          },
                        )
                      : _buildDefaultAvatar(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SvgIconButton( 
      icon: AppsIcons.arrowLeft,
      onTap: onBackPressed ?? () => Navigator.of(context).pop(),
      color: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          (userName?.isNotEmpty == true) ? userName![0].toUpperCase() : 'U',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    if (isHomeStyle) {
      return const Size.fromHeight(130);
    }
    return Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0),
    );
  }
}

class CustomAppBarWithSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;

  const CustomAppBarWithSearch({
    super.key,
    required this.title,
    this.searchHint,
    this.onSearchChanged,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppBar(
      title: Column(
        crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: foregroundColor ?? theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onSearchChanged != null) ...[
            const SizedBox(height: 8),
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                onChanged: onSearchChanged,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: searchHint ?? 'Search...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  prefixIcon: SvgIconButton(    
                    icon: AppsIcons.search,
                    onTap: () {},
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      elevation: elevation,
      centerTitle: false,
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      actions: actions,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SvgIconButton(
      icon: AppsIcons.arrowLeft,
      onTap: onBackPressed ?? () => Navigator.of(context).pop(),
      color: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (onSearchChanged != null ? 60 : 0),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final Function(String)? onChanged;
  final Function()? onFilterPressed;
  final String? hintText;

  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.onFilterPressed,
    this.hintText,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search input field
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Search clothes...',
                  hintStyle: TextStyle(
                    color: AppColors.tertiary,
                    fontSize: 16,
                  ),
                  prefixIcon: SvgIcon(
                    AppsIcons.search,
                    color: AppColors.tertiary,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Filter button
          GestureDetector(
            onTap: widget.onFilterPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}