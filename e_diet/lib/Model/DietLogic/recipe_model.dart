/* This class is responsible for getting and displaying meals 
in our webview
*/
class Recipe {
  final String spoonacularSourceUrl;
  final String image;
  final String sourceName;
  final String summary;
  final double calories, fat, protein, carbs;
//has Equipment, Ingredients, Steps, e.t.c
  // double get getclories => calories;
  // set setclories(double _calories) => calories = _calories;

  Recipe({
    this.spoonacularSourceUrl,
    this.image,
    this.sourceName,
    this.calories,
    this.carbs,
    this.summary,
    this.fat,
    this.protein,
  });
//The spoonacularSourceURL displays the meals recipe in our webview
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
      image: map['image'],
      sourceName: map['sourceName'],
      summary: map['summary'],
      calories: map['nutrition']['nutrients'][0]['amount'],
      carbs: map['nutrition']['nutrients'][3]['amount'],
      fat: map['nutrition']['nutrients'][1]['amount'],
      protein: map['nutrition']['nutrients'][8]['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'spoonacularSourceUrl': this.spoonacularSourceUrl,
        'image': this.image,
        'sourceName': this.sourceName,
        'summary': this.sourceName,
        'calories': calories,
        'fat': fat,
        'protein': protein,
        'carbs': carbs
      };
}
