import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/models/models.dart';
import 'package:firebase_chat/providers/base_provider.dart';
import 'package:firebase_chat/services/services.dart';
import 'package:firebase_chat/utils/constants/constants.dart';
import 'package:firebase_chat/utils/enums/src/firebaseauth_enums.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends BaseProvider {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // AuthProvider({
  //   required this.googleSignIn,
  //   required this.firebaseAuth,
  //   required this.firebaseFirestore,
  // });

  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.uninitialized;
  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        SharedPreferencesService.getString(FirestoreConstants.id)?.isNotEmpty ==
            true) {
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseAuthStatus> handleSignIn() async {
    _isLoading = true;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
      log(firebaseUser.toString());
      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });

          User? currentUser = firebaseUser;
          await SharedPreferencesService.setString(
              FirestoreConstants.id, currentUser.uid);
          await SharedPreferencesService.setString(
              FirestoreConstants.nickname, currentUser.displayName ?? "");
          await SharedPreferencesService.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await SharedPreferencesService.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
          await SharedPreferencesService.setString(
              FirestoreConstants.id, userChat.id);
          await SharedPreferencesService.setString(
              FirestoreConstants.nickname, userChat.nickname);
          await SharedPreferencesService.setString(
              FirestoreConstants.photoUrl, userChat.photoUrl);
          await SharedPreferencesService.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _firebaseAuthStatus = FirebaseAuthStatus.authenticated;
        notifyListeners();
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.authenticateCanceled;

        notifyListeners();
      }
    } else {
      _firebaseAuthStatus = FirebaseAuthStatus.authenticateError;
      notifyListeners();
    }

    return _firebaseAuthStatus;
  }

  Future<void> handleSignOut() async {
    _firebaseAuthStatus = FirebaseAuthStatus.authenticating;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      log("ERROR ${e.toString()}");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      log("ERROR ${e.toString()}");
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log("ERROR ${e.toString()}");
      return null;
    }
  }
}
