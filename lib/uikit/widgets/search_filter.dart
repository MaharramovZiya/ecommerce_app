import 'package:flutter/material.dart';
import 'package:ecommerce_apps/core/constants/app_colors.dart';
import 'package:ecommerce_apps/uikit/base/base_text_field.dart';

class SearchBarWithFilter extends StatelessWidget {
  const SearchBarWithFilter({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔍 CustomTextField istifadə olunur
        Expanded(
          child: CustomTextField(
            controller: controller,
            hintText: "Search clothes...",
            prefixIcon: Icons.search,
            onChanged: onChanged,
          ),
        ),

        const SizedBox(width: 12),

        // ⚙️ Filter düyməsi
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
