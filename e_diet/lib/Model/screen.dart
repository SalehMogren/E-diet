import 'package:e_diet/Model/ApiServices.dart';
import 'package:e_diet/Model/meal_plan_model.dart';

import 'package:e_diet/Model/Meal_model.dart';
import 'package:e_diet/Model/recipe_model.dart';
import 'package:e_diet/Model/recipe_screen.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatefulWidget {
  //It returns a final mealPlan variable
  final MealPlan mealPlan;
  MealsScreen({this.mealPlan});
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
/*
Returns aContainer with Curved edges and a BoxShadow. 
The child is a column widget that returns nutrient information in Rows
 */
  _buildTotalNutrientsCard() {
    return Container(
      height: 140,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carb: ${widget.mealPlan.carbs.toString()} cal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//This method below takes in parameters meal and index
  _buildMealCard(Meal meal, int index) {
    //We define a String variable mealType, that equals method called mealType
    String mealType = _mealType(index);
    //We return stack widget with center alignment
    return GestureDetector(
      //We wrap our stack with gesture detector to navigate to webview page
/*
      The async onTap function will fetch the recipe by id using the 
      fetchRecipe method.
      It will then navigate to RecipeScreen, while parsing in our mealType and recipe
       */
      onTap: () async {
        Recipe recipe =
            await ApiService.instance.fetchRecipe(meal.id.toString());
        print(recipe.image.toString());
        print(recipe.spoonacularSourceUrl.toString());
        print(recipe.sourceName.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeScreen(
                      mealType: mealType,
                      recipe: recipe,
                    )));
      },
      child: Stack(alignment: Alignment.center, children: <Widget>[
        //First widget is a container that loads decoration image
        Container(
          height: 220,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
              ]),
        ),
        //Second widget is a Container that has 2 text widgets
        Container(
          margin: EdgeInsets.all(60),
          padding: EdgeInsets.all(10),
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                //mealtype
                mealType,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              Text(
                //mealtitle
                meal.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ]),
    );
  }

/*
mealType returns Breakfast, Lunch or Dinner, depending on the index value
*/
  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //has an appBar
      appBar: AppBar(title: Text('Your Meal Plan')),
      //and body as a ListView builder
      body: ListView.builder(
          /*
        We set itemCount to 1 + no. of meals, which based on our API call,
        the no. of meals should always be 3
        */
          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (BuildContext context, int index) {
            /*
            If index is 0, we return a method called _buildTotalNutrientsCard()
            */
            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
            /*
            Otherwise, we return a buildMealCard method that takes in the meal,
            and index - 1
            */
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
}
