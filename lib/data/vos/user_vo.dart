import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {

  @JsonKey(name: "profile_picture")
  String? profile;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "region")
  String? region;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "qr_code")
  String? qrCode;

  @JsonKey(name: "fcm_token")
  String? fcmToken;


  UserVO(
      {
      this.profile,
      this.name,
      this.region,
      this.phone,
      this.password,
      this.email,
      this.qrCode,
      this.fcmToken});

  @override
  String toString() {
    return 'UserVO{ profile: $profile, name: $name, region: $region, phone: $phone, password: $password, email: $email, qrCode: $qrCode, fcmToken: $fcmToken}';
  }

  factory UserVO.fromJson(Map<String, dynamic> json) =>
      _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
