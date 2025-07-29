import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await credential.user?.updateDisplayName(name);
      //
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('faild to sign in with error---> ${e.toString()}');
    }
    return null;
  }
}
