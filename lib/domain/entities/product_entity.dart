import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final List<String> images;
  final String category;
  final String brand;
  final List<String> sizes;
  final List<String> colors;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final bool isNew;
  final bool isOnSale;
  final List<String>? tags;
  final Map<String, String>? specifications;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.images,
    required this.category,
    required this.brand,
    required this.sizes,
    required this.colors,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.isFeatured,
    required this.isNew,
    required this.isOnSale,
    this.tags,
    this.specifications,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        originalPrice,
        images,
        category,
        brand,
        sizes,
        colors,
        stock,
        rating,
        reviewCount,
        isFeatured,
        isNew,
        isOnSale,
        tags,
        specifications,
        createdAt,
        updatedAt,
      ];

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    List<String>? images,
    String? category,
    String? brand,
    List<String>? sizes,
    List<String>? colors,
    int? stock,
    double? rating,
    int? reviewCount,
    bool? isFeatured,
    bool? isNew,
    bool? isOnSale,
    List<String>? tags,
    Map<String, String>? specifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      images: images ?? this.images,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      isOnSale: isOnSale ?? this.isOnSale,
      tags: tags ?? this.tags,
      specifications: specifications ?? this.specifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
