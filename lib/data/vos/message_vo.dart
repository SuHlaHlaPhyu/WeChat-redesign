import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "file")
  String? file;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_pic")
  String? profilePic;

  @JsonKey(name: "timestamp")
  String? timestamp;

  @JsonKey(name: "user_id")
  String? userId;

  @JsonKey(name: "is_video")
  bool? isVideo;

  MessageVO(
      {this.file,
      this.message,
      this.name,
      this.profilePic,
      this.timestamp,
      this.userId,
      this.isVideo});

  @override
  String toString() {
    return 'MessageVO{file: $file, message: $message, name: $name, profilePic: $profilePic, timestamp: $timestamp, userId: $userId, isVideo: $isVideo}';
  }

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
