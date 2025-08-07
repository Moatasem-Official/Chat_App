import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        throw 'email-already-in-use';
      } else {
        throw 'unknown-error';
      }
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException code: ${e.code}');

      switch (e.code) {
        case 'user-not-found':
          throw 'user-not-found';
        case 'wrong-password':
          throw 'wrong-password';
        case 'invalid-credential':
          throw 'invalid-credentials';
        case 'too-many-requests':
          throw 'too-many-requests';
        default:
          throw 'unknown-error';
      }
    }
  }
}
