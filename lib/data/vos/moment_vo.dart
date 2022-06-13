import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "post_file")
  String? postFile;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "is_video")
  bool? isVideo;


  MomentVO(
      {this.id,
      this.description,
      this.postFile,
      this.profilePicture,
      this.userName,
      this.isVideo});


  @override
  String toString() {
    return 'MomentVO{id: $id, description: $description, postFile: $postFile, profilePicture: $profilePicture, userName: $userName, isVideo: $isVideo}';
  }

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
