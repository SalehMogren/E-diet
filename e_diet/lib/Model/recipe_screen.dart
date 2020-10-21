import 'package:flutter/material.dart';
import 'recipe_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  //This stateful widget page takes in String mealType and Recipe recipe
  final String mealType;
  final Recipe recipe;
  RecipeScreen({this.mealType, this.recipe});
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is widget.mealType
      appBar: AppBar(
        title: Text(widget.mealType),
      ),
      /**
       * Body is a Webview. Ensure you have imported webview flutter.
       * 
       * initialUrl- spoonacularSourceUrl of our parsed in recipe
       * javascriptMode - set to unrestricted so as JS can load in the webview
       */
      body: WebView(
        initialUrl: widget.recipe.sourceUrl,
        //JS unrestricted, so that JS can execute in the webview
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
