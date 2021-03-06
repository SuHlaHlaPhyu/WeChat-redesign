import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class SignUpBloc extends ChangeNotifier {
  bool isDisposed = false;
  String region = "";
  String password = "";
  String userName = "";
  String phone = "";
  UserVO? craftUser;
  File? chosenImage;
  String fcmToken = "";
  bool isAccepted = false;

  void onPhoneChanged(String phone) {
    this.phone = phone;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onUserNameChanged(String userName) {
    this.userName = userName;
  }

  void selectRegion(String region) {
    this.region = region;
  }

  void onImageChosen(File imageFile, Uint8List bytes) {
    chosenImage = imageFile;
    notifyListeners();
  }

  void tokenGenerate(String token) {
    fcmToken = token;
    notifyListeners();
  }

  void onTapAccepted() {
    isAccepted = !isAccepted;
    notifyListeners();
  }

  Future<UserVO?> getUserInfo() {
    craftUser?.name = userName;
    craftUser?.region = region;
    craftUser?.password = password;
    craftUser?.phone = phone;
    craftUser?.fcmToken = fcmToken;
    notifyListeners();
    return Future.value(UserVO(
      name: userName,
      region: region,
      password: password,
      phone: phone,
      fcmToken: fcmToken,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
