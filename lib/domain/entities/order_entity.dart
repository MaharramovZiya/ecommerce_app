import 'package:equatable/equatable.dart';
import 'cart_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final String shippingAddress;
  final String billingAddress;
  final double? shippingFee;
  final double? discount;
  final double? tax;
  final String? notes;
  final String? trackingNumber;
  final DateTime? estimatedDelivery;
  final DateTime? deliveredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.billingAddress,
    this.shippingFee,
    this.discount,
    this.tax,
    this.notes,
    this.trackingNumber,
    this.estimatedDelivery,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        totalAmount,
        status,
        paymentMethod,
        shippingAddress,
        billingAddress,
        shippingFee,
        discount,
        tax,
        notes,
        trackingNumber,
        estimatedDelivery,
        deliveredAt,
        createdAt,
        updatedAt,
      ];

  OrderEntity copyWith({
    String? id,
    String? userId,
    List<CartItemEntity>? items,
    double? totalAmount,
    String? status,
    String? paymentMethod,
    String? shippingAddress,
    String? billingAddress,
    double? shippingFee,
    double? discount,
    double? tax,
    String? notes,
    String? trackingNumber,
    DateTime? estimatedDelivery,
    DateTime? deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingFee: shippingFee ?? this.shippingFee,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      notes: notes ?? this.notes,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}
