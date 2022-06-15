// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      file: json['file'] as String?,
      message: json['message'] as String?,
      name: json['name'] as String?,
      profilePic: json['profile_pic'] as String?,
      timestamp: json['timestamp'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'file': instance.file,
      'message': instance.message,
      'name': instance.name,
      'profile_pic': instance.profilePic,
      'timestamp': instance.timestamp,
      'user_id': instance.userId,
    };
