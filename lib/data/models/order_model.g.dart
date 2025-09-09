// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  status: json['status'] as String,
  paymentMethod: json['paymentMethod'] as String,
  shippingAddress: json['shippingAddress'] as String,
  billingAddress: json['billingAddress'] as String,
  shippingFee: (json['shippingFee'] as num?)?.toDouble(),
  discount: (json['discount'] as num?)?.toDouble(),
  tax: (json['tax'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  trackingNumber: json['trackingNumber'] as String?,
  estimatedDelivery: json['estimatedDelivery'] == null
      ? null
      : DateTime.parse(json['estimatedDelivery'] as String),
  deliveredAt: json['deliveredAt'] == null
      ? null
      : DateTime.parse(json['deliveredAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'shippingFee': instance.shippingFee,
      'discount': instance.discount,
      'tax': instance.tax,
      'notes': instance.notes,
      'trackingNumber': instance.trackingNumber,
      'estimatedDelivery': instance.estimatedDelivery?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'items': instance.items,
    };
