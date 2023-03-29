import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_chat/locator.dart';
// import 'package:firebase_chat/providers/providers.dart';
import 'package:firebase_chat/services/firebase/firestore.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
// import 'package:firebase_chat/core/utils/enums/src/firebaseauth_enums.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import '../base_viewmodel.dart';

class ChatListViewModel extends BaseViewModel {
  final FirestoreService firestoreService;
  final SharedPreferencesService sharedPreferencesService;
  ChatListViewModel(
      {required this.firestoreService, required this.sharedPreferencesService});
  Stream<QuerySnapshot>? chatlistStream;
  String username = "";

  void getChatList() async {
    String userName = sharedPreferencesService.getUserUid() ?? "";
    log(userName);
    username = userName;
    if (userName != "") {
      Stream<QuerySnapshot> chats = await firestoreService.getUsers(userName);
      chatlistStream = chats;
    }
    notifyListeners();
  }

  void checkChatroomId(String chatroomId) async {
    bool hasChatroom =await firestoreService.checkChatroomId(chatroomId);
    if (!hasChatroom) {
      
    } 
  }
}
