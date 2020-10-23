//import meal_model.dart
import 'package:e_diet/Model/DietLogic/Meal_model.dart';

class MealPlan {
  //MealPlan class has a list of meals and nutritional info about the meal plan
  final List<Meal> meals;
  final double calories, carbs, fat, protein;
  MealPlan({this.meals, this.calories, this.carbs, this.fat, this.protein});
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
}
