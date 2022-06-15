import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';

const newsFeedCollection = "moments";
const fileUploadRef = "uploads";
const usersCollection = "users";

class DataAgentImpl extends DataAgent {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;
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
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) => credential.user?..updateDisplayName(newUser.name))
        .then((user) {
      newUser.qrCode = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return fireStore
        .collection(usersCollection)
        .doc(newUser.qrCode.toString())
        .set(newUser.toJson());
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Stream<UserVO> getLoggedInUser(){
    return fireStore
        .collection(usersCollection)
        .doc(auth.currentUser?.uid.toString())
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((event) =>
            UserVO.fromJson(Map<String, dynamic>.from(event.data()!)));
  }
}
