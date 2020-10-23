import 'Meal_model.dart';

class Nutrition {
  double calories,
      carbs,
      fat,
      protein,
      bmr,
      caloriesLeft,
      carbsLeft,
      fatLeft,
      proteinLeft;

  Nutrition(
    String gender,
    double height,
    double weight,
    int age,
    String activity,
    String goal,
  ) {
    if (gender == 'male')
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    else {
      bmr = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
    }
    switch (activity) {
      case 'Very Active':
        {
          calories = bmr * 1.725;
        }
        break;
      case 'Modrate':
        {
          calories = bmr * 1.55;
        }
        break;
      case 'Light':
        {
          calories = bmr * 1.375;
        }
        break;
      case 'Sedentarty':
        {
          calories = bmr * 1.2;
        }
        break;
    }
    switch (goal) {
      case 'Gain':
        {
          calories += 500;
        }
        break;
      case 'Maintain':
        {
          calories = bmr;
        }
        break;
      case 'Lose':
        {
          calories -= 500;
        }
        break;
    }
    carbs = (0.5 * calories) / 4;
    protein = (0.25 * calories) / 4;
    fat = (0.25 * calories) / 9;
    caloriesLeft = calories;
    carbsLeft = carbs;
    fatLeft = fat;
    proteinLeft = protein;
  }

  ate(Meal meal) {
    caloriesLeft -= meal.recipe.calories;
    carbsLeft -= meal.recipe.carbs;
    proteinLeft -= meal.recipe.protein;
    fatLeft -= meal.recipe.fat;
  }
}
