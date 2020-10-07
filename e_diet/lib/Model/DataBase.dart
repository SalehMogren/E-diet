import 'package:firebase_auth/firebase_auth.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
CollectionReference users = _db.collection('users');

Future<void> addUser(User user, String name) {
  String userNmae = user.displayName == null ? name : user.displayName;
  return users
      .doc(user.uid)
      .set({'name': userNmae, 'email': user.email, 'photoUrl': user.photoURL})
      .then((value) => print('User Added'))
      .catchError((onError) => print("Failed To Print $onError"));
}

Future<void> setUserHealth(
    String uid, int age, int weight, int height, String gender) {
  return users
      .doc(uid)
      .update({
        'age': age,
        'weight': weight,
        'height': height,
        'gender': gender,
      })
      .then((value) => print('User Health is Set'))
      .catchError((onError) => print('Failed to set user Health $onError'));
}

Future<void> setUserGoal(String uid, int goal) {
  // 0 :  Gain
  // 1 : Maintain
  // 2 : Lose
  String goalString = '';

  switch (goal) {
    case 0:
      {
        goalString = 'Gain';
      }
      break;
    case 1:
      {
        goalString = 'Maintain';
      }
      break;
    case 2:
      {
        goalString = 'Lose';
      }
      break;
  }
  return users
      .doc(uid)
      .update({
        'goal': goalString,
      })
      .then((value) => print('User Set Goal Successfully'))
      .catchError((onError) => print('Failed To Set Goal $onError'));
}

Future<bool> getUserEmail(User user) async {
  bool found = false;
  await users
      .where('email', isEqualTo: user.email)
      .get()
      .then((value) => () {
            found = true;
            print("User Found");
          })
      .catchError((onError) => () {
            found = false;
            print('Failed to find user $onError');
          });

  return found;
}
