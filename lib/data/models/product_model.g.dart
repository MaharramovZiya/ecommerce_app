// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  originalPrice: (json['originalPrice'] as num).toDouble(),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  category: json['category'] as String,
  brand: json['brand'] as String,
  sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
  colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  stock: (json['stock'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  isFeatured: json['isFeatured'] as bool,
  isNew: json['isNew'] as bool,
  isOnSale: json['isOnSale'] as bool,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  specifications: (json['specifications'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'images': instance.images,
      'category': instance.category,
      'brand': instance.brand,
      'sizes': instance.sizes,
      'colors': instance.colors,
      'stock': instance.stock,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'isFeatured': instance.isFeatured,
      'isNew': instance.isNew,
      'isOnSale': instance.isOnSale,
      'tags': instance.tags,
      'specifications': instance.specifications,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
