//import meal_model.dart

import 'package:e_diet/Model/DietLogic/Meal_model.dart';

class MealPlan {
  //MealPlan class has a list of meals and nutritional info about the meal plan
  final List<Meal> meals;
  final double calories, carbs, fat, protein;
  MealPlan({this.meals, this.calories, this.carbs, this.fat, this.protein});

  factory MealPlan.fromDB(Map<String, dynamic> map) {
    List<Meal> meals = [];
    meals.add(Meal.fromDB(map['meals']['Breakfast']));
    meals.add(Meal.fromDB(map['meals']['Lunch']));
    meals.add(Meal.fromDB(map['meals']['Dinner']));

    return MealPlan(
      meals: meals,
      calories: map['calories'],
      carbs: map['carbs'],
      fat: map['fat'],
      protein: map['protein'],
    );
  }
/*
The factory constructor iterates over the list of meals and our decoded mealplan
data and creates a list of meals.
Then, we return MealPlan object with all the information 
*/
  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = [];
    map['meals'].forEach((mealMap) => meals.add(Meal.fromMap(mealMap)));

    //Add meals dish type based on order
    meals.forEach((element) {
      switch (meals.indexOf(element)) {
        case 0:
          element.dishType = 'Breakfast';
          break;
        case 1:
          element.dishType = 'Lunch';
          break;
        case 2:
          element.dishType = 'Dinner';
          break;
      }
    });
    //MealPlan object with information we want
    return MealPlan(
      meals: meals,
      calories: map['nutrients']['calories'],
      carbs: map['nutrients']['carbohydrates'],
      fat: map['nutrients']['fat'],
      protein: map['nutrients']['protein'],
    );
  }

  Map<String, dynamic> toJson1() => {
        'calories': calories,
        'carbs': carbs,
        'fat': fat,
        'protein': protein,
        'meals': _mealsToJson(),
      };

  Map<String, dynamic> _mealsToJson() {
    // Map<String, dynamic> jMeals = Map.fromIterable(
    //   this.meals,
    //   key: (element) => element.dishType,
    //   value: (element) => element.toJson(),
    // );
    Map<String, dynamic> jMeals = new Map();
    if (this.meals.isNotEmpty)
      this.meals.forEach((element) {
        if (element != null) jMeals[element.dishType] = element.toJson();
      });
    return jMeals;
  }
}
