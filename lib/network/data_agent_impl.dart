import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/data_agent.dart';

const newsFeedCollection = "moments";
const fileUploadRef = "uploads";
const usersCollection = "users";
const contactsCollection = "contacts";
const contactsAndMessages = "contactsAndMessages";

class DataAgentImpl extends DataAgent {
  static final DataAgentImpl _singleton = DataAgentImpl._internal();

  DataAgentImpl._internal();

  factory DataAgentImpl() {
    return _singleton;
  }

  /// fire store
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  /// realtime
  var databaseRef = FirebaseDatabase.instance.reference();

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
        .then((credential) => credential.user
          ?..updateDisplayName(newUser.name)
          ..updatePhotoURL(newUser.profile))
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
  Stream<UserVO> getLoggedInUser() {
    return fireStore
        .collection(usersCollection)
        .doc(auth.currentUser?.uid.toString())
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((event) =>
            UserVO.fromJson(Map<String, dynamic>.from(event.data()!)));
  }

  Future<UserVO> getUserByID(String? qr) {
    return fireStore
        .collection(usersCollection)
        .doc(qr.toString())
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((event) =>
            UserVO.fromJson(Map<String, dynamic>.from(event.data()!)))
        .first;
  }

  @override
  UserVO getLogInUser() {
    return UserVO(
      name: auth.currentUser?.displayName,
      profile: auth.currentUser?.photoURL,
      qrCode: auth.currentUser?.uid,
    );
  }

  @override
  Future addToContact(String qrCode) {
    return getUserByID(qrCode).then((value) {
      return fireStore
          .collection(usersCollection)
          .doc(auth.currentUser?.uid)
          .collection(contactsCollection)
          .doc()
          .set(value.toJson())
          .whenComplete(() {
        return getUserByID(auth.currentUser?.uid).then((value) => fireStore
            .collection(usersCollection)
            .doc(qrCode)
            .collection(contactsCollection)
            .doc()
            .set(value.toJson()));
      });
    });
  }

  @override
  Stream<List<UserVO>> getContacts() {
    return fireStore
        .collection(usersCollection)
        .doc(auth.currentUser?.uid)
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(MessageVO message, String receiverId) {
    return databaseRef
        .child(contactsAndMessages)
        .child(auth.currentUser?.uid ?? "")
        .child(receiverId)
        .child(message.timestamp.toString())
        .set(message.toJson())
        .whenComplete(() {
      return databaseRef
          .child(contactsAndMessages)
          .child(receiverId)
          .child(auth.currentUser?.uid ?? "")
          .child(message.timestamp.toString())
          .set(message.toJson());
    });
  }

  @override
  Stream<List<MessageVO>> getConversationsList(String userId) {
    return databaseRef
        .child(contactsAndMessages)
        .child(auth.currentUser?.uid ?? "")
        .child(userId)
        .onValue
        .map((event) {
      return event.snapshot.value.values.map<MessageVO>((element) {
        return MessageVO.fromJson(
          Map<String, dynamic>.from(element),
        );
      }).toList();
    });
  }
}
