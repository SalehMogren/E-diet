/* This class is responsible for getting and displaying meals 
in our webview
*/
class Recipe {
  final String sourceUrl;
//has Equipment, Ingredients, Steps, e.t.c
  Recipe({
    this.sourceUrl,
  });
//The spoonacularSourceURL displays the meals recipe in our webview
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      sourceUrl: map['sourceUrl'],
    );
  }
}
