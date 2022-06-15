import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ConversationBloc extends ChangeNotifier {
  PlatformFile? chosenFile;
  bool isDisposed = false;
  File? chosenImage;
  bool? isFromCamera = false;
  String? receiverUserId;
  String message = "";
  UserVO? loginUser;

  DataModel dataModel = DataModelImpl();

  ConversationBloc(String? receiverId) {
    receiverUserId = receiverId;
    loginUser = dataModel.getLogInUser();
    _notifySafely();
  }

  void sendMessage(String message){
    prepareMessageVO(message).then((value) {
      dataModel.sendMessage(value, receiverUserId ?? "");
      _notifySafely();
    });
  }

  Future<MessageVO> prepareMessageVO(String message){
    var messageObj = MessageVO(
      message: message,
      name: loginUser?.name,
      profilePic: loginUser?.profile,
      userId: loginUser?.qrCode,
      file: "",
    );
    return Future.value(messageObj);
  }

  void onChangeMessage(String message){
    this.message = message;
  }

  void onFileChosen(PlatformFile? imageFile) {
    if (imageFile?.extension != "mp4") {
      chosenFile = imageFile;
    } else {
      chosenFile = imageFile;
    }
    _notifySafely();
  }

  void onImageChosen(File imageFile, Uint8List bytes) {
    chosenImage = imageFile;
    isFromCamera = true;
    notifyListeners();
  }

  void onTapDeleteImage() {
    chosenFile = null;
    chosenImage = null;
    isFromCamera = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
