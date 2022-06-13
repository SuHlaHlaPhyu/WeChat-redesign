import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';

const newsFeedCollection = "moments";
const fileUploadRef = "uploads";
class DataAgentImpl extends DataAgent{
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Stream<List<MomentVO>> getMoments() {
    return fireStore
        .collection(newsFeedCollection)
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> addNewMoment(MomentVO post) {
    return fireStore
        .collection(newsFeedCollection)
        .doc(post.id.toString())
        .set(post.toJson());
  }

  @override
  Future<void> deleteMoment(int postId) {
    return fireStore
        .collection(newsFeedCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return fireStore
        .collection(newsFeedCollection)
        .doc(momentId.toString())
        .get()
        .asStream()
        .where((documentSnapshot) => documentSnapshot.data() != null)
        .map((documentSnapshot) {
      return MomentVO.fromJson(
          Map<String, dynamic>.from(documentSnapshot.data()!));
    });
  }

  @override
  Future<void> editPost(MomentVO newsFeed) {
    // TODO: implement editPost
    throw UnimplementedError();
  }

}