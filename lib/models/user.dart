import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String token;
  final String email;
  final String name;
  final String photoUrl;

  const UserModel({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.token,
    required this.id,
  } );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? email,
    String? name,
    String? photoUrl,
    String? token,
    String? id,
  }) =>
      UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        token: token ?? this.token,
        id: id ?? this.id,
      );
}
