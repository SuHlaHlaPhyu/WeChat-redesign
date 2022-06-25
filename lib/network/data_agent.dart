import 'dart:io';

import 'package:wechat_redesign/data/vos/chat_history_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';


abstract class DataAgent {
  /// moments
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(MomentVO post);
  Future<void> deleteMoment(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<String> uploadFileToFirebase(File image);

  /// auth
  Future registerNewUser(UserVO newUser);
  Future login(String email, String password);
  Future logOut();
  bool isLoggedIn();
  Stream<UserVO> getLoggedInUser();
  UserVO getLogInUser();
  Future<UserVO> getUserByID(String? qr);

  /// contact
  Future addToContact(String qrCode);
  Stream<List<UserVO>> getContacts();

  /// conversation
  Future<void> sendMessage(MessageVO message,String receiverId);
  Stream<List<MessageVO>> getConversationsList(String userId);

  /// chat history
  Stream<List<String>> chatHistory();
  Stream<String> getConversationsLastMessage(String userId);
  Future<void> deleteConversation(String contactId);
}