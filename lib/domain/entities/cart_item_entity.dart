import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String image;
  final int quantity;
  final String size;
  final String color;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    this.size = '',
    this.color = '',
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        name,
        price,
        image,
        quantity,
        size,
        color,
        createdAt,
        updatedAt,
      ];

  CartItemEntity copyWith({
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
    return CartItemEntity(
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

  double get totalPrice => price * quantity;
}
