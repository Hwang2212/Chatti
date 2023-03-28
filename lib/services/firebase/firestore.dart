import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/utils/utils.dart';

class FirestoreService {
  // static Firestore
  static FirebaseFirestore? _firestore;
  static FirebaseFirestore? get firestore => _firestore;
  static FirestoreService? _instance;

  static Future<FirestoreService> getInstance() async {
    if (_instance != null) return _instance!;
    _firestore = _firestore ?? FirebaseFirestore.instance;
    _instance = FirestoreService();
    return _instance!;
  }

  Future<QuerySnapshot> getUserDetails(String userUid) async {
    return _firestore!
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: userUid)
        .get();
  }

  Future<void> createUser(User firebaseUser) async {
    _firestore!
        .collection(FirestoreConstants.pathUserCollection)
        .doc(firebaseUser.uid)
        .set({
      'username': firebaseUser.displayName,
      'email': firebaseUser.email ?? "",
      'photoUrl': firebaseUser.photoURL,
      'id': firebaseUser.uid
    });
  }

  getUserInfo(String email) async {
    return _firestore!
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      log(e.toString());
    });
  }

  createUserInfo() async {}

  createChatRoom(Map<String, dynamic> usersMap) {
    return _firestore!
        .collection(FirestoreConstants.chatroomCollection)
        .add(usersMap);
  }

  Future<Stream<QuerySnapshot>> getUserChats(String userUid) async {
    return _firestore!
        .collection(FirestoreConstants.chatroomCollection)
        .where(FirestoreConstants.usersUid, arrayContains: userUid)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChats(String chatroomId) async {
    return _firestore!
        .collection(FirestoreConstants.chatroomCollection)
        .doc(chatroomId)
        .collection(FirestoreConstants.chatCollection)
        .orderBy(FirestoreConstants.timeUpdated)
        .snapshots();
  }

  Future<void> addMessage(String chatroomId, message) async {
    try {
      _firestore!
          .collection(FirestoreConstants.chatroomCollection)
          .doc(chatroomId)
          .collection(FirestoreConstants.chatCollection)
          .add(message);
    } catch (e) {
      log("ERROR: Firestore - $e");
    }
  }
}
