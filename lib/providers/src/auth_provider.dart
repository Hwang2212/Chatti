import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/providers/base_provider.dart';
import 'package:firebase_chat/utils/enums/src/firebaseauth_enums.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends BaseProvider {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // AuthProvider({
  //   required this.googleSignIn,
  //   required this.firebaseAuth,
  //   required this.firebaseFirestore,
  // });

  FirebaseAuthStatus get _firebaseAuthStatus =>
      FirebaseAuthStatus.uninitialized;
  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}
