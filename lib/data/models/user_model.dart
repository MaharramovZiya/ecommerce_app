import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.phone,
    super.avatar,
    @JsonKey(name: 'date_of_birth') super.dateOfBirth,
    super.gender,
    super.address,
    @JsonKey(name: 'created_at') super.createdAt,
    @JsonKey(name: 'updated_at') super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      phone: entity.phone,
      avatar: entity.avatar,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      address: entity.address,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      phone: phone,
      avatar: avatar,
      dateOfBirth: dateOfBirth,
      gender: gender,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? avatar,
    DateTime? dateOfBirth,
    String? gender,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
