import 'dart:io';

import 'package:wechat_redesign/data/vos/moment_vo.dart';


abstract class DataAgent {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(MomentVO post);
  Future<void> deleteMoment(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<String> uploadFileToFirebase(File image);
  Future<void> editPost(MomentVO newsFeed);
}