import 'package:e_diet/Model/ApiServices.dart';
import 'package:e_diet/Model/recipe_model.dart';
import 'package:flutter/services.dart';

class Meal {
  int id;
  String imageType;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;
  Recipe recipe;

  Meal(int id, String imageType, String title, int readyInMinutes, int servings,
      String sourceUrl) {
    this.id = id;
    this.imageType = imageType;
    this.title = title;
    this.readyInMinutes = readyInMinutes;
    this.servings = servings;
    this.sourceUrl = sourceUrl;
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    Meal meal = Meal(
      map['id'],
      map['imageType'],
      map['title'],
      map['readyInMinutes'],
      map['servings'],
      map['sourceUrl'],
    );
    ApiService.instance
        .fetchRecipe(map['id'].toString())
        .then((value) => meal.recipe = value);

    return meal;
  }
}
