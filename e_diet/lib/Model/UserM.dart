import 'dart:async';

import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/DietLogic/Nutrition.dart';
import 'package:e_diet/Model/Services/ApiServices.dart';
import 'package:e_diet/Model/DietLogic/meal_plan_model.dart';
import 'package:e_diet/Model/Services/DataBase.dart';
// import 'package:e_diet/Pages/home/Favorite/favorite.dart';
import 'package:flutter/cupertino.dart';

import 'Services/DataBase.dart';

class UserModle extends ChangeNotifier {
  String uid;
  int _age;
  double _weight, _height;
  String _gender, _goal, photoUrl, name, email, _diet;
  Nutrition _nutrition;
  Map<String, dynamic> _info = new Map<String, dynamic>();
  String s;
  MealPlan mealPlan;
  List<Meal> favMeals = new List();
  String _activityLevel;
  Map<String, Map<String, Meal>> _diary = new Map();
  UserModle(String uid) {
    this.uid = uid;
  }
  bool isNuteUpdated = false;
  String get diet => _diet;

  int get age => _age;
  // set age(int age) => _age = age;

  double get weight => _weight;

  String get goal => _goal;
  // set weight(double weight) => _weight = weight;

  double get height => _height;
  // set height(double height) => _height = height;

  String get gender => _gender;
  // set gender(String gender) => _gender = gender;
  Nutrition get nutrition {
    if (_diary[today] != null) {
      _diary[today].values.map((e) {
        _nutrition.caloriesEaten += e.recipe.calories;
        _nutrition.caloriesEaten += e.recipe.carbs;
        _nutrition.fatEaten += e.recipe.fat;
        _nutrition.proteinEaten += e.recipe.protein;
        print('${_diary[today].values.length}');
      });
    }
    return _nutrition;
  }

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

  Map<String, Map<String, Meal>> get diary => _diary;

  void setdiet(String diet) => _diet = diet;

  Future<UserModle> fetchData() async {
    if (name == null) {
      await Future.delayed(Duration(seconds: 0), await fetchUserInfo());
    }
    if (_nutrition == null)
      _nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
    if (mealPlan == null) {
      await Future.delayed(Duration(seconds: 2), await fetchUserPlan());
    }
    if (_diary.isEmpty) {
      _diary = await getUserDiary(this.uid);
    }
    updateNutretion();

    // print('fetch data');
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
      _nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
      notifyListeners();
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
      _nutrition =
          new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
      notifyListeners();
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

    _nutrition =
        new Nutrition(_gender, _height, _weight, _age, _activityLevel, _goal);
    notifyListeners();

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
      // print('User Date Has Been Fetched');
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
      checkUserMealPlan(this.uid).then((value) async {
        if (!value) {
          await ApiService.instance
              .generateMealPlan(
                  uid: this.uid,
                  diet: diet,
                  targetCalories: this.nutrition.calories.toInt())
              .then((value) {
            this.mealPlan = value;
            print('MealPlan Has Been Fetched');
            // Future.delayed(
            //     Duration(seconds: 2), () => addUserMealPlan(uid, mealPlan));
          }).catchError((onError) =>
                  print('Failed To Fetch User MealPlan to UM $onError'));
        } else
          getUserMealPlan(this.uid, this.diet, this.nutrition.calories.toInt())
              .then((value) => this.mealPlan = value);
      });

    // await getUserMealPlan(uid, diet, this.nutrition.calories.toInt())
    //     .then((value) {
    //   this.mealPlan = value;
    // })
    //     // await ApiService.instance
    //     //     .generateMealPlan(
    //     //         diet: diet, targetCalories: this.nutrition.calories.toInt())
    //     //     .then((value) {
    //     //   this.mealPlan = value;
    //     //   print('MealPlan Has Been Fetched');
    //     // })
    //     .catchError((onError) =>
    //         print('Failed To Fetch User MealPlan to UM $onError'));
  }

  eat(Meal meal, int mealType) {
    String mealtype;
    switch (mealType) {
      case 0:
        mealtype = 'Breakfast';
        break;
      case 1:
        mealtype = 'Lunch';
        break;
      case 2:
        mealtype = 'Dinner';
        break;
    }
    this.nutrition.ate(meal);
    meal.eaten = true;
    addMealToDiary(meal, mealtype);
    editMealPlanDB(this.uid, meal, mealtype);
    notifyListeners();
  }

  addFavMeal(Meal meal) {
    if (favMeals.indexOf(meal) == -1) favMeals.add(meal);

    //add to db

    notifyListeners();
  }

  removeFavMeal(Meal meal) {
    if (favMeals.indexOf(meal) != -1) favMeals.remove(meal);
    // remove from db
    notifyListeners();
  }

  removeMealFromDiary(Meal meal, String date, String mealType) async {
    print('Deleting the meal..');
    _diary[date][mealType].eaten = false;
    if (date == today) {
      int ind;
      switch (mealType) {
        case 'Breakfast':
          ind = 0;
          break;
        case 'Lunch':
          ind = 1;
          break;
        case 'Dinner':
          ind = 2;
          break;
      }

      mealPlan.meals[ind].eaten = false;
      await editMealPlanDB(uid, meal, mealType);
      isNuteUpdated = false;
      updateNutretion();
    }
    _diary[date].remove(mealType);
    removeMealFromDiaryDB(this.uid, date, mealType);
    notifyListeners();
  }

  addMealToDiary(Meal meal, String mealtype) {
    if (_diary.containsKey(today)) {
      if (!_diary[today].containsKey(mealtype))
        _diary[today].putIfAbsent(mealtype, () => meal);
      else
        _diary[today].update(mealtype, (value) => meal);
    } else
      _diary[today] = {mealtype: meal};
    notifyListeners();
    addEatenMeal(this.uid, meal, mealtype);
  }

  editMealServing(Meal meal, String date, int value, String mealType) async {
    _diary[date][mealType].servings = value;
    await editMealDB(this.uid, diary[date][mealType], date, mealType);
    notifyListeners();
  }

  void updateNutretion() {
    if (mealPlan.meals.isNotEmpty) if (!isNuteUpdated) {
      _nutrition.caloriesEaten = 0;
      _nutrition.carbsEaten = 0;
      _nutrition.fatEaten = 0;
      _nutrition.proteinEaten = 0;
      mealPlan.meals.forEach((element) {
        if (element.eaten) {
          _nutrition.caloriesEaten += element.recipe.calories;
          _nutrition.carbsEaten += element.recipe.carbs;
          _nutrition.fatEaten += element.recipe.fat;
          _nutrition.proteinEaten += element.recipe.protein;
          isNuteUpdated = true;
        }
      });
    }
    // if (mealPlan.meals.any((element) {
    //   return element.eaten ? true : false;
    // })) {
    //   _diary[today].values.map((e) {
    //     _nutrition.caloriesEaten += e.recipe.calories;
    //     _nutrition.caloriesEaten += e.recipe.carbs;
    //     _nutrition.fatEaten += e.recipe.fat;
    //     _nutrition.proteinEaten += e.recipe.protein;
    //     print('${_diary[today].values.length}');
    //   });
    // }
  }

  suggestAnotherMeal(int id, String mealtype) async {
    int mealtypeIndex;
    switch (mealtype) {
      case 'Breakfast':
        mealtypeIndex = 0;
        break;
      case 'Lunch':
        mealtypeIndex = 1;
        break;
      case 'Dinner':
        mealtypeIndex = 2;
        break;
    }
    Meal newMeal;
    await ApiService.instance
        .fetchSimilar(id)
        .then((value) => newMeal = value)
        .catchError((onError) => print('Failed to fetch new Meal $onError'));
    await Future.delayed(const Duration(seconds: 2), () {
      if (newMeal != null && newMeal.recipe != null) {
        mealPlan.meals[mealtypeIndex] = newMeal;
        newMeal.dishType = mealtype;
        editMealDB(this.uid, newMeal, today, mealtype);
      }
    });

    notifyListeners();
  }
}
