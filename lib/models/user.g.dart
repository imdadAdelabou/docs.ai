// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      token: json['token'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
    };
