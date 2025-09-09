import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cart_item_entity.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.name,
    required super.price,
    required super.image,
    required super.quantity,
    super.size = '',
    super.color = '',
    super.createdAt,
    super.updatedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image']?.toString() ?? '',
      quantity: (json['quantity'] as int?) ?? 1,
      size: json['size']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'].toString()) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at'].toString()) 
          : null,
    );
  }

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      image: entity.image,
      quantity: entity.quantity,
      size: entity.size,
      color: entity.color,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      productId: productId,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
      size: size,
      color: color,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
    String? size,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
