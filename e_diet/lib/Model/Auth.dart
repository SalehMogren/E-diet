import 'package:e_diet/Model/UserM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  // final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj based on firebaseuser(user)

  UserModle _userFromFireBaseUser(User user) {
    return user != null ? UserModle(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<UserModle> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFireBaseUser);
  }

//sign in anon

  Future signInAo() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    // ignore: deprecated_member_use
    User user = _auth.currentUser;
    print('user email = ${user.email}');
  }

  // Future googleSignIn() async {
  //   // Step 1
  //   GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  //   // Step 2
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     // ignore: deprecated_member_use
  //     AuthCredential credential = GoogleAuthProvider.getCredential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken
  //     );

  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     User user = result.user;
  //     return _userFromFireBaseUser(user);
  //   }
  // }

  // TO DO
  // void updateUserData(FirebaseUser user) async {
  //
  //
  // }

// sign In
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _googleSignIn.disconnect();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
