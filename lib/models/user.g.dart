// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] != null ? json['photoUrl'] as String : '',
      token: json['token'] != null ? json['token'] as String : '',
      id: json['_id'] as String,
      isNewUser: json['isNewUser'] != null ? json['isNewUser'] as bool : null,
      provider: json['provider'] != null ? json['provider'] as String : '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'provider': instance.provider,
    };
