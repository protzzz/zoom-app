import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_app/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // initialization autorization
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // initialization cloud storage

  // func returns TRUE if autorization went well
  // context is for Exception error handling
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn()
              .signIn(); // opens Google dialog-window to choose an account, if decline - returns 0
      final GoogleSignInAuthentication? googleAuth =
          await googleUser
              ?.authentication; // to autorize a user in Firebase as well
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      ); // creates user data for FirebaseAuth based on Google's tokens

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      ); // entrance to Firebase, returns UserCredential from whos u can get user or meta-info

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        } // if new user - creates new one in collection 'users'
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }

    return res; // if everything ok -> returns true
  }
}
