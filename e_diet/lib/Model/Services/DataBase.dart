import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/DietLogic/meal_plan_model.dart';
import 'package:e_diet/Model/Services/ApiServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// Use Constant Variables That Will Be Used Store In DB
//To Prevent Errors Like Spelling Mistakes
const String NameDB = 'name';
const String EmailDB = 'email';
const String PhotoUrlDB = 'photoUrl';
const String AgeDB = 'age';
const String WeightDB = 'weight';
const String HeightDB = 'height';
const String GoalDB = 'goal';
const String ActivityLevelDB = 'activityLevel';
const String GenderDB = 'gender';
const String DiaryDB = 'diary';
const String MealPlanDB = 'mealplan';
const String NutretionsDB = 'nutretion';
final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference users = _db.collection('users');
String today = "${DateFormat("M-d-y").format(DateTime.now())}";
// Add User To DB by Creating a new Document with uid
Future<void> addUser(User user, String name) async {
  String userNmae = user.displayName == null ? name : user.displayName;
  return users
      .doc(user.uid)
      .set({
        NameDB: userNmae,
        EmailDB: user.email,
        PhotoUrlDB: user.photoURL == null ? 'null' : user.photoURL
      })
      .then((value) => print('User Added'))
      .catchError((onError) => print("Failed To Print $onError"));
}

//Add User Health Info In DB To The Doc Intiated With uid
Future<void> setUserHealthDB(
    String uid, int age, double weight, double height, String gender) {
  return users
      .doc(uid)
      .update({
        AgeDB: age,
        WeightDB: weight,
        HeightDB: height,
        GenderDB: gender,
      })
      .then((value) => print('User Health is Set'))
      .catchError((onError) => print('Failed to set user Health $onError'));
}

//Add User Goal Info In DB To The Doc Intiated With uid
Future<void> setUserGoalDB(String uid, String goalString) {
  return users
      .doc(uid)
      .update({
        GoalDB: goalString,
      })
      .then((value) => print('User Set Goal Successfully'))
      .catchError((onError) => print('Failed To Set Goal $onError'));
}

Future<void> setUserActivityLevelDB(String uid, String activityLevelString) {
  return users
      .doc(uid)
      .update({
        ActivityLevelDB: activityLevelString,
      })
      .then((value) => print('User Set ActivityLevel Successfully'))
      .catchError((onError) => print('Failed To Set ActivityLevel $onError'));
}

//Serach UserEmail In DB
Future<bool> getUserEmail(User user) async {
  print('Called');
  return users.where('email', isEqualTo: user.email).get().then((value) {
    if (value.size > 0) {
      print('Document exists on the database');
      return true;
    } else {
      print('Document not exists on the database');

      return false;
    }
  }).catchError((onError) => () {
        print('Failed to find user $onError');
        return false;
      });
}

//Fetch User Data From DB through uid
Future<Map<String, dynamic>> fetchUserInfoDB(String uid) async {
  Map<String, dynamic> userInfo = new Map<String, dynamic>();
  await users.doc(uid).get().then((value) {
    userInfo.addAll({
      NameDB: value[NameDB],
      EmailDB: value[EmailDB],
      AgeDB: value[AgeDB],
      WeightDB: value[WeightDB],
      HeightDB: value[HeightDB],
      GoalDB: value[GoalDB],
      GenderDB: value[GenderDB],
      PhotoUrlDB: value[PhotoUrlDB],
      ActivityLevelDB: value[ActivityLevelDB],
    });
    // print('User Data Has Been Fetched To Model');
  }).catchError(
      (onError) => print('Failed to Fetch User Data to model $onError'));

  return userInfo.isEmpty ? null : userInfo;
}

Stream<DocumentSnapshot> getUserDoc(String uid) {
  return users.doc(uid).snapshots().handleError(
      (onError) => print('Failed To Get User Doc From DB : $onError'));
}

// Add user's mealplan for the today's
Future<void> addUserMealPlan(String uid, MealPlan mealPlan) {
  return checkUserMealPlan(uid).then((value) {
    if (!value)
      return users
          .doc(uid)
          .collection(MealPlanDB)
          .doc(today)
          .set({MealPlanDB: mealPlan.toJson1()})
          .then((value) => print('User Meal Plan has been added to DB'))
          .catchError(
              (onError) => print('Faild to add user mealplan to db $onError'));
  });
}

// get user's mealplan for todays , check if its not exist call the api to add it \
Future<MealPlan> getUserMealPlan(String uid, String diet, int calories) async {
  return users
      .doc(uid)
      .collection(MealPlanDB)
      .doc(today)
      .get()
      .then((value) => MealPlan.fromDB(value.data()[MealPlanDB]));
}

Future<bool> checkUserMealPlan(String uid) {
  return users.doc(uid).collection(MealPlanDB).doc(today).get().then((value) {
    if (value.exists) {
      print('User Mealplan Doc found');

      return true;
    } else {
      print('User Mealplan Doc NOT found');

      return false;
    }
  }).catchError((onError) {
    print('Failed to find user meal $onError');
    return false;
  });
}

// Add user's eaten Meals to the database
Future<void> addEatenMeal(String uid, Meal meal, String mealtype) {
  // if doc is not created
  return getUserEatenMeals(uid, today).then((value) {
    if (!value)
      users
          .doc(uid)
          .collection(DiaryDB)
          .doc(today)
          .set({
            mealtype: meal.toJson(),
          })
          .then((value) => print('User Meal added to db'))
          .catchError(
              (onError) => print('Faild to add user meal to db $onError'));
    else
      return users
          .doc(uid)
          .collection(DiaryDB)
          .doc(today)
          .update({
            mealtype: meal.toJson(),
          })
          .then((value) => print('User Meal added to db'))
          .catchError(
              (onError) => print('Faild to add user meal to db $onError'));
  }).catchError(
      (onError) => print('Faild To excute addMeal to db Method $onError'));
}

// get User's eaten Meals docs for today
Future<bool> getUserEatenMeals(String uid, String date) {
  return users.doc(uid).collection(DiaryDB).doc(date).get().then((value) {
    if (value.data().isNotEmpty) {
      print('User Meals Doc found');

      return true;
    } else {
      print('User Meals Doc NOT found');

      return false;
    }
  }).catchError((onError) {
    print('Failed to find user eaten meals');
    return false;
  });
}

// get User's Diary from DB
Future<Map<String, Map<String, Meal>>> getUserDiary(String uid) {
  Map<String, Map<String, Meal>> diary = new Map();
  //1st accesss the user db
  //2nd store in Map<"date",List<Meal>>
  //3rd return the data to user model
  return users.doc(uid).collection(DiaryDB).get().then((value) {
    value.docs.forEach((e) {
      // print('Docs Are accessed');
      // loop through a doc and take the meals and store it in the dayMeals var
      Map<String, Meal> dayMeals = new Map();
      e.data().forEach((key, value) {
        dayMeals[key] = Meal.fromDB(value);
        // print("Meal ${dayMeals.keys.first}");
      });
      diary[e.id] = dayMeals;
    });
    // print("User diary has been fetched");
    // print("Diary Contains : ${diary.length}");
    return diary;
  }).catchError((onError) => print('Failed to fetch User Diary $onError'));
}

Future<void> removeMealFromDiaryDB(String uid, String date, String mealType) {
  return users
      .doc(uid)
      .collection(DiaryDB)
      .doc(date)
      .update({mealType: FieldValue.delete()})
      .then((value) => print('Meal removed from DB'))
      .catchError((onError) => print('Failed to remove meal from DB'));
}
