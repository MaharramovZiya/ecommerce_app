import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  @JsonKey(name: 'date_of_birth')
  final DateTime? dateOfBirth;
  final String? gender;
  final String? address;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        avatar,
        dateOfBirth,
        gender,
        address,
        createdAt,
        updatedAt,
      ];

  UserEntity copyWith({
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
    return UserEntity(
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
