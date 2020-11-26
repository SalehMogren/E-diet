import 'package:e_diet/Model/Services/ApiServices.dart';
import 'package:e_diet/Model/DietLogic/recipe_model.dart';

class Meal {
  int id;
  String imageType;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;
  String dishType;
  Recipe recipe;
  bool eaten = false;
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

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'imageType': this.imageType,
        'title': this.title,
        'readyInMinutes': this.readyInMinutes,
        'servings': this.servings,
        'sourceUrl': this.sourceUrl,
        'dishType': this.dishType,
        'recipe': this.recipe.toJson(),
        'eaten': this.eaten
      };

  factory Meal.fromDB(Map<String, dynamic> map) {
    Meal meal = Meal(
      map['id'],
      map['imageType'],
      map['title'],
      map['readyInMinutes'],
      map['servings'],
      map['sourceUrl'],
    );
    meal.recipe = Recipe.fromDB(map['recipe']);
    meal.dishType = map['dishType'];
    if (map.containsKey('eaten')) meal.eaten = map['eaten'];
    return meal;
  }
}
