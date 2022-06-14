import 'dart:io';

import 'package:wechat_redesign/data/models/data_model.dart';
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
      print("======> with image");
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
        userName: "Su Hla Phyu",
        postFile: fileUrl,
        profilePicture:
            "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        description: description,
        isVideo: isVideoFile);
    print("=======> prepare craft newsfeed");
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
  Future<void> register(UserVO? userVO,File? imageFile) {
    if(imageFile != null){
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then(
            (downloadUrl) => craftUserVOForRegister(userVO, downloadUrl).then(
              (user) => mDataAgent.registerNewUser(user),
        ),
      );
    }else{
      return mDataAgent.registerNewUser(userVO!);
    }

  }
}
