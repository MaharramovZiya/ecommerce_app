import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderEntity {
  @override
  final List<CartItemModel> items;

  OrderModel({
    required String id,
    required String userId,
    required this.items,
    required double totalAmount,
    required String status,
    required String paymentMethod,
    required String shippingAddress,
    required String billingAddress,
    double? shippingFee,
    double? discount,
    double? tax,
    String? notes,
    String? trackingNumber,
    DateTime? estimatedDelivery,
    DateTime? deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          userId: userId,
          items: items.map((item) => item.toEntity()).toList(),
          totalAmount: totalAmount,
          status: status,
          paymentMethod: paymentMethod,
          shippingAddress: shippingAddress,
          billingAddress: billingAddress,
          shippingFee: shippingFee,
          discount: discount,
          tax: tax,
          notes: notes,
          trackingNumber: trackingNumber,
          estimatedDelivery: estimatedDelivery,
          deliveredAt: deliveredAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      items: entity.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      totalAmount: entity.totalAmount,
      status: entity.status,
      paymentMethod: entity.paymentMethod,
      shippingAddress: entity.shippingAddress,
      billingAddress: entity.billingAddress,
      shippingFee: entity.shippingFee,
      discount: entity.discount,
      tax: entity.tax,
      notes: entity.notes,
      trackingNumber: entity.trackingNumber,
      estimatedDelivery: entity.estimatedDelivery,
      deliveredAt: entity.deliveredAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      status: status,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      shippingFee: shippingFee,
      discount: discount,
      tax: tax,
      notes: notes,
      trackingNumber: trackingNumber,
      estimatedDelivery: estimatedDelivery,
      deliveredAt: deliveredAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  OrderModel copyWithModel({
    String? id,
    String? userId,
    List<CartItemModel>? items,
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
    return OrderModel(
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
}
