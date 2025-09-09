import '../../domain/entities/favorite_entity.dart';
import '../../domain/entities/product_entity.dart';
import 'product_model.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required super.id,
    required super.userId,
    required super.product,
    super.createdAt,
    super.updatedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    // Əgər products məlumatı varsa, onu istifadə et
    if (json['products'] != null) {
      return FavoriteModel(
        id: json['id']?.toString() ?? '',
        userId: json['user_id']?.toString() ?? '',
        product: ProductModel.fromJson(json['products']),
        createdAt: json['created_at'] != null 
            ? DateTime.tryParse(json['created_at'].toString()) 
            : null,
        updatedAt: json['updated_at'] != null 
            ? DateTime.tryParse(json['updated_at'].toString()) 
            : null,
      );
    } else {
      // Sadəcə product_id varsa, boş product yarat
      return FavoriteModel(
        id: json['id']?.toString() ?? '',
        userId: json['user_id']?.toString() ?? '',
        product: ProductEntity(isNew: false, isFeatured: false, isOnSale: false, stock: 0
        ,rating: 0.0, reviewCount: 0,
        tags: [],
        specifications: {},
        createdAt: null,
        updatedAt: null,
          id: json['product_id']?.toString() ?? '',
          name: 'Loading...',
          price: 0.0,
          originalPrice: 0.0,
          brand: '',
          images: [],
          category: '',
          description: '',
        
          sizes: [],
          colors: [],
     
        ),
        createdAt: json['created_at'] != null 
            ? DateTime.tryParse(json['created_at'].toString()) 
            : null,
        updatedAt: json['updated_at'] != null 
            ? DateTime.tryParse(json['updated_at'].toString()) 
            : null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'products': ProductModel.fromEntity(product).toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      userId: entity.userId,
      product: ProductModel.fromEntity(entity.product),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      userId: userId,
      product: product,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
