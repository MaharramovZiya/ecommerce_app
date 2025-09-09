import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.originalPrice,
    required super.images,
    required super.category,
    required super.brand,
    required super.sizes,
    required super.colors,
    required super.stock,
    required super.rating,
    required super.reviewCount,
    required super.isFeatured,
    required super.isNew,
    required super.isOnSale,
    super.tags,
    super.specifications,
    super.createdAt,
    super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      originalPrice: entity.originalPrice,
      images: entity.images,
      category: entity.category,
      brand: entity.brand,
      sizes: entity.sizes,
      colors: entity.colors,
      stock: entity.stock,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      isFeatured: entity.isFeatured,
      isNew: entity.isNew,
      isOnSale: entity.isOnSale,
      tags: entity.tags,
      specifications: entity.specifications,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      originalPrice: originalPrice,
      images: images,
      category: category,
      brand: brand,
      sizes: sizes,
      colors: colors,
      stock: stock,
      rating: rating,
      reviewCount: reviewCount,
      isFeatured: isFeatured,
      isNew: isNew,
      isOnSale: isOnSale,
      tags: tags,
      specifications: specifications,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  ProductModel copyWith({
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
    return ProductModel(
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
