import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/providers/base_provider.dart';
import 'package:firebase_chat/utils/enums/src/firebaseauth_enums.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends BaseProvider {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // AuthProvider({
  //   required this.googleSignIn,
  //   required this.firebaseAuth,
  //   required this.firebaseFirestore,
  // });

  FirebaseAuthStatus get _firebaseAuthStatus =>
      FirebaseAuthStatus.uninitialized;
  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  Future<void> handleSignIn() async {
    _isLoading = true;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
    } else {}
  }
}
