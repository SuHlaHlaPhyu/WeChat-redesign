import 'dart:io';

import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

abstract class DataModel {
  /// moments
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? file, bool isVideo);
  Future<void> deleteMoment(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> editMoment(MomentVO? newsFeed, File? image);

  /// auth
  Future<void> register(UserVO? userVO,File? imageFile);
  Future<void> login(String email, String password);
  bool isLoggedIn();
  Stream<UserVO> getLoggedInUser();
  UserVO getLogInUser();
  Future<void> logOut();
  Future<UserVO> getUserByID(String? qr);

  /// contact
  Future<void> addToContact(String qrCode);
  Stream<List<UserVO>> getContacts();

  /// conversation
  Future<void> sendMessage(MessageVO message,String receiverId,File? sentFile);
  Stream<List<MessageVO>> getConversationsList(String userId);
  Stream<String> getConversationsLastMessage(String userId);
  Stream<List<String>> chatHistory();
  Future<void> deleteConversation(String contactId);
}