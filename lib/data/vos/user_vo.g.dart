// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      profile: json['profile_picture'] as String?,
      name: json['name'] as String?,
      region: json['region'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      qrCode: json['qr_code'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'profile_picture': instance.profile,
      'name': instance.name,
      'region': instance.region,
      'phone': instance.phone,
      'password': instance.password,
      'email': instance.email,
      'qr_code': instance.qrCode,
      'fcm_token': instance.fcmToken,
    };
