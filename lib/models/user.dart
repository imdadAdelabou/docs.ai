import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// Represents the user data
@JsonSerializable()
class UserModel {
  /// Creates [UserModel] instance
  const UserModel({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.token,
    required this.id,
    this.isNewUser,
  });

  /// A function to convert a JSON to a UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// The unique id of a user
  final String id;

  /// The token used to grant access to a certain features to a user
  final String token;

  /// Contains the email of a user
  final String email;

  /// Contains the name of a user
  final String name;

  /// Contains the profile picture of a user
  final String photoUrl;

  /// To know if the current user is a new user or not
  final bool? isNewUser;

  /// A function that returns a JSON representation of the UserModel instance
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// A function to make a copy of the UserModel instance
  UserModel copyWith({
    String? email,
    String? name,
    String? photoUrl,
    String? token,
    String? id,
    bool? isNewUser,
  }) =>
      UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        token: token ?? this.token,
        id: id ?? this.id,
        isNewUser: isNewUser ?? this.isNewUser,
      );
}
