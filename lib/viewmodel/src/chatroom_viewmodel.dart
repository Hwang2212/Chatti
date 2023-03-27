import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/services/firebase/firestore.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
import 'package:firebase_chat/core/utils/enums/src/firebaseauth_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../base_viewmodel.dart';

class ChatroomViewModel extends BaseViewModel {
  final FirestoreService firestoreService;
  final SharedPreferencesService sharedPreferencesService;
  ChatroomViewModel(
      {required this.firestoreService, required this.sharedPreferencesService});
  Stream<QuerySnapshot>? chatroomStream;
  String username = "";

  void getChats(String chatroomId) async {
    String userName = sharedPreferencesService.getUserUid() ?? "";
    username = userName;
    if (userName != "") {
      Stream<QuerySnapshot> chats = await firestoreService.getChats(chatroomId);
      chatroomStream = chats;
    }
    notifyListeners();
  }
}
