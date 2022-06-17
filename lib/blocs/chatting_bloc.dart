import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/data/vos/chat_history_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';
import 'package:wechat_redesign/network/data_agent_impl.dart';

class ConversationBloc extends ChangeNotifier {
  PlatformFile? chosenFile;
  bool isDisposed = false;
  File? chosenImage;
  bool? isFromCamera = false;
  String? receiverUserId;
  String message = "";
  UserVO? loginUser;
  File? sentFile;
  bool isVideo = false;
  List<MessageVO>? conversationList;
  bool isLoading = false;

  DataModel dataModel = DataModelImpl();
  DataAgent dataAgent = DataAgentImpl();

  ConversationBloc(String? receiverId) {
    dataAgent.chatHistory().listen((event) {
      print("========> bloc $event");
    });
    receiverUserId = receiverId;
    loginUser = dataModel.getLogInUser();
    _notifySafely();
    dataModel.getConversationsList(receiverId ?? "").listen((event) {
      conversationList = event.reversed.toList();
      _notifySafely();
    });
  }

  void sendMessage(String message){
    prepareMessageVO(message).then((value) {
      if(chosenFile != null){
        sentFile = File(chosenFile?.path.toString() ?? "");
      }else if (chosenImage != null){
        sentFile = chosenImage;
      }else {
        sentFile = null;
      }
      _showLoading();
      dataModel.sendMessage(value, receiverUserId ?? "",sentFile).then((value) {
        sentFile = null;
        chosenImage = null;
        chosenFile = null;
        isVideo = false;
        _hideLoading();
        _notifySafely();
      });
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
      isVideo: isVideo,
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
      isVideo = true;
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

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
