import 'dart:io';

import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';
import 'package:wechat_redesign/network/data_agent_impl.dart';

class DataModelImpl extends DataModel {
  static final DataModelImpl _singleton = DataModelImpl._internal();

  factory DataModelImpl() {
    return _singleton;
  }

  DataModelImpl._internal();

  DataAgent mDataAgent = DataAgentImpl();

  @override
  Future<void> addNewMoment(String description, File? file, bool isVideo) {
    if (file != null) {
      return mDataAgent
          .uploadFileToFirebase(file)
          .then(
              (downloadUrl) => craftMomentVO(description, downloadUrl, isVideo))
          .then(
            (newPost) => mDataAgent.addNewMoment(newPost),
          );
    } else {
      return craftMomentVO(description, "", isVideo).then(
        (newPost) => mDataAgent.addNewMoment(newPost),
      );
    }
  }

  Future<MomentVO> craftMomentVO(
      String description, String fileUrl, bool isVideoFile) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newMoment = MomentVO(
        id: currentMilliseconds,
        userName: mDataAgent.getLogInUser().name,
        postFile: fileUrl,
        profilePicture: mDataAgent.getLogInUser().profile,
        description: description,
        isVideo: isVideoFile);
    return Future.value(newMoment);
  }

  Future<MomentVO> craftMomentVOForEdit(MomentVO? newsFeed, String imageUrl) {
    newsFeed?.postFile = imageUrl;
    return Future.value(newsFeed);
  }

  @override
  Future<void> deleteMoment(int postId) {
    return mDataAgent.deleteMoment(postId);
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    return mDataAgent.getMoments();
  }

  @override
  Future<void> editMoment(MomentVO? newsFeed, File? image) {
    if (image != null) {
      return mDataAgent
          .uploadFileToFirebase(image)
          .then((downloadUrl) => craftMomentVOForEdit(newsFeed, downloadUrl))
          .then((value) => mDataAgent.addNewMoment(value));
    } else {
      return mDataAgent.addNewMoment(newsFeed!);
    }
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  Future<UserVO> craftUserVOForRegister(UserVO? userVO, String imageUrl) {
    userVO?.profile = imageUrl;
    return Future.value(userVO);
  }

  @override
  Future<void> register(UserVO? userVO, File? imageFile) {
    if (imageFile != null) {
      return mDataAgent.uploadFileToFirebase(imageFile).then(
            (downloadUrl) => craftUserVOForRegister(userVO, downloadUrl).then(
              (user) => mDataAgent.registerNewUser(user),
            ),
          );
    } else {
      return mDataAgent.registerNewUser(userVO!);
    }
  }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Stream<UserVO> getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  UserVO getLogInUser() {
    return mDataAgent.getLogInUser();
  }

  @override
  Future<void> addToContact(String qrCode) {
    return mDataAgent.addToContact(qrCode);
  }

  @override
  Stream<List<UserVO>> getContacts() {
    return mDataAgent.getContacts();
  }

  Future<MessageVO> craftMessageVO(MessageVO messageVO) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    messageVO.timestamp = currentMilliseconds.toString();
    return Future.value(messageVO);
  }

  Future<MessageVO> craftMessageVOWithImage(
      MessageVO? messageVO, String imageUrl) {
    messageVO?.file = imageUrl;
    return Future.value(messageVO);
  }

  @override
  Future<void> sendMessage(
      MessageVO message, String receiverId, File? sentFile) {
    if (sentFile != null) {
      return craftMessageVO(message).then(
        (value) => mDataAgent.uploadFileToFirebase(sentFile).then(
              (imageUrl) => craftMessageVOWithImage(message, imageUrl).then(
                (value) => mDataAgent.sendMessage(message, receiverId),
              ),
            ),
      );
    } else {
      return craftMessageVO(message)
          .then((value) => mDataAgent.sendMessage(value, receiverId));
    }
  }

  @override
  Stream<List<MessageVO>> getConversationsList(String userId) {
    return mDataAgent.getConversationsList(userId);
  }
}
