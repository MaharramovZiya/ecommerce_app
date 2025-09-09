import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;

  const ProductImageCarousel({
    super.key,
    required this.images,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 300,
        color: AppColors.background,
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            size: 64,
            color: AppColors.secondary,
          ),
        ),
      );
    }

    return Column(
      children: [
        // Image Carousel
        Container(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.background,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.background,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.secondary,
                    size: 64,
                  ),
                ),
              );
            },
          ),
        ),
        
        // Page Indicators
        if (widget.images.length > 1)
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.tertiary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
