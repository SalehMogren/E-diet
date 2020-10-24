import 'dart:async';

import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/DietLogic/Nutrition.dart';
import 'package:e_diet/Model/Services/ApiServices.dart';
import 'package:e_diet/Model/DietLogic/meal_plan_model.dart';

import 'Services/DataBase.dart';

class UserModle {
  final String uid;
  int _age;
  double _weight, _height;
  String _gender, _goal, photoUrl, name, email;
  Nutrition nutrition;
  Map<String, dynamic> _info = new Map<String, dynamic>();
  MealPlan mealPlan;
  String _activityLevel;
  UserModle({this.uid});

  int get age => _age;
  // set age(int age) => _age = age;

  double get weight => _weight;

  String get goal => _goal;
  // set weight(double weight) => _weight = weight;

  double get height => _height;
  // set height(double height) => _height = height;

  String get gender => _gender;
  // set gender(String gender) => _gender = gender;

  Future<Map<String, dynamic>> get info async {
    if (name == null) await fetchUserInfo();
    return {
      NameDB: this.name,
      EmailDB: this.email,
      AgeDB: this._age,
      WeightDB: this._weight,
      HeightDB: this._height,
      GoalDB: this._goal,
      GenderDB: this._gender,
      PhotoUrlDB: this.photoUrl,
    };
  }

  Future<UserModle> fetchData() async {
    if (name == null) {
      await Future.delayed(Duration(seconds: 0), await fetchUserInfo());
    }
    if (nutrition == null)
      nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);

    if (mealPlan == null)
      await Future.delayed(Duration(seconds: 2), await fetchUserPlan());

    print('fetch data');
    return this;
  }

  setUserHealth(
      String uid, int age, double weight, double height, String gender) async {
    this._age = age;
    this._weight = weight;
    this._height = height;
    this._gender = gender;
    if (_goal != null) {
      setInfo();
      nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
    }

    await setUserHealthDB(uid, age, weight, height, gender)
        .then((value) => null)
        .catchError((onError) => print('$onError'));
  }

  setUserActivityLevel(String userUdi, int activityLevel) async {
    // 0 :  Very Active
    // 1 : Modrate
    // 2 : Light
    // 3 : Sedentarty
    String activityLevelString = '';

    switch (activityLevel) {
      case 0:
        {
          activityLevelString = 'Very Active';
        }
        break;
      case 1:
        {
          activityLevelString = 'Modrate';
        }
        break;
      case 2:
        {
          activityLevelString = 'Light';
        }
        break;
      case 3:
        {
          activityLevelString = 'Sedentarty';
        }
        break;
    }
    this._activityLevel = activityLevelString;
    if (_goal != null) {
      nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
    }
    await setUserActivityLevelDB(uid, activityLevelString);
    fetchUserInfo();

    setInfo();
  }

  setUserGoal(String userUid, int goal) async {
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
    this._goal = goalString;

    nutrition =
        new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);

    await setUserGoalDB(uid, goalString);
    fetchUserInfo();
    setInfo();
  }

  //Fetch User Info From DB
  fetchUserInfo() async {
    await fetchUserInfoDB(uid).then((value) {
      value.forEach((key, value) {
        switch (key) {
          case NameDB:
            this.name = value;
            print(name);
            break;
          case EmailDB:
            this.email = value;
            break;
          case PhotoUrlDB:
            this.photoUrl = value;
            break;
          case AgeDB:
            this._age = value;
            break;
          case WeightDB:
            this._weight = value;
            break;
          case HeightDB:
            this._height = value;
            break;
          case GoalDB:
            this._goal = value;
            break;
          case GenderDB:
            this._gender = value;
            break;
          case ActivityLevelDB:
            this._activityLevel = value;
        }
      });
      print('User Date Has Been Fetched');
    }).catchError((onError) => print('Failed To Fetch $onError'));
  }

  setInfo() {
    _info.addAll({
      NameDB: this.name,
      EmailDB: this.email,
      AgeDB: this._age,
      WeightDB: this._weight,
      HeightDB: this._height,
      GoalDB: this._goal,
      GenderDB: this._gender,
      PhotoUrlDB: this.photoUrl,
      ActivityLevelDB: this._activityLevel
    });
  }

  fetchUserPlan() async {
    if (this.mealPlan == null)
      await ApiService.instance
          .generateMealPlan(
              diet: 'None', targetCalories: this.nutrition.calories.toInt())
          .then((value) {
        this.mealPlan = value;
        print('MealPlan Has Been Fetched');
      }).catchError(
              (onError) => print('Failed To Fetch User MealPlan $onError'));
  }

  eat(Meal meal) {
    this.nutrition.ate(meal);
    controller.sink.add(this);
  }

  // ignore: close_sinks
  final StreamController<UserModle> controller = StreamController<UserModle>();

  Stream<UserModle> get stream {
    Stream st = Stream.fromFuture(fetchData());
    fetchData();
    return controller.stream.asBroadcastStream();
  }
}
