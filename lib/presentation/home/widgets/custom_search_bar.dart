import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'package:ecommerce_apps/uikit/components/svg_icon.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          hintText: AppStrings.searchClothes,
          hintStyle: TextStyle(
            color: AppColors.secondary,
            fontSize: AppSizes.fontSizeM,
          ),
          prefixIcon: const SvgIcon(
            AppsIcons.search,
            color: AppColors.secondary,
            size: 20,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon:  SvgIcon(
                    AppsIcons.minus,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearch('');
                  },
                )
              : const SvgIcon(
                  AppsIcons.filter,
                  color: AppColors.secondary,
                  size: 20,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingM,
          ),
        ),
      ),
    );
  }
}
