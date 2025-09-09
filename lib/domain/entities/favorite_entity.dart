import 'package:equatable/equatable.dart';
import 'product_entity.dart';

class FavoriteEntity extends Equatable {
  final String id;
  final String userId;
  final ProductEntity product;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FavoriteEntity({
    required this.id,
    required this.userId,
    required this.product,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, product, createdAt, updatedAt];
}
