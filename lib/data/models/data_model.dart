import 'dart:io';

import 'package:wechat_redesign/data/vos/moment_vo.dart';

abstract class DataModel {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewMoment(String description, File? file, bool isVideo);
  Future<void> deleteMoment(int postId);
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> editMoment(MomentVO? newsFeed, File? image);
}