/* This class is responsible for getting and displaying meals 
in our webview
*/
class Recipe {
  final String spoonacularSourceUrl;
  final String image;
  final String sourceName;
//has Equipment, Ingredients, Steps, e.t.c
  Recipe({this.spoonacularSourceUrl, this.image, this.sourceName});
//The spoonacularSourceURL displays the meals recipe in our webview
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
      image: map['image'],
      sourceName: map['sourceName'],
    );
  }
}
