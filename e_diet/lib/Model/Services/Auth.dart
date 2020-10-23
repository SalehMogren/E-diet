import 'package:e_diet/Model/UserM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'DataBase.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
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

  String userUid() {
    return _userFromFireBaseUser(_auth.currentUser).uid;
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

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print("1");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print("2");

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("3");

    UserCredential result = await _auth.signInWithCredential(credential);

    // ignore: deprecated_member_use
    User user = result.user;

    // Check user already exist ? linkGoogle Account to it : Create new user
    print('user email = ${user.email}');
    // If user exist ? true : false;
    return getUserEmail(user).then((value) async {
      if (!value) {
        print(!value);
        await addUser(user, user.displayName);
        return true;
      } else
        return false;
    }).catchError((onError) => print('Failed To find User $onError'));
  }

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

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // Add User To DB by Creating a new Document with uid

      addUser(user, name);

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future changePass(String pass) async {
    try {
      await _auth.currentUser
          .updatePassword(pass)
          .then((value) => _userFromFireBaseUser(_auth.currentUser));
    } catch (e) {
      print('Error Happend When Changing The pass : $e');
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      User user = _auth.currentUser;
      print(user.providerData[0].providerId);
      if (user.providerData[0].providerId == 'google.com') {
        await _googleSignIn.disconnect();
      }
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<bool> checkUserEmailInDB() async {
    return getUserEmail(_auth.currentUser);
  }
}

// add to profile page
void linkGoogleAccount(User user) {}
