import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/Services/Auth.dart';
import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final AuthService _auth = AuthService();

  List<MealTest> mealsBreakFast = [
    MealTest('Egg', 80, '2 eggs'),
    MealTest('bacon', 180, '1.5 oz'),
    MealTest('Milk', 40, '200 ml'),
    MealTest('Bread', 100, '2 oz'),
  ];

  @override
  Widget build(BuildContext context) {
    var modle = Provider.of<UserModle>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Favorite',
            textAlign: TextAlign.center,
            style: TextStyle(color: EDpinkAcc),
          ),
        ),
        centerTitle: true,
        leading: null,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<UserModle>(
              future: modle.fetchData(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Text('Loading..');
                if (snapshot.hasError)
                  return Text('Error');
                else
                  return Column(
                    children: snapshot.data.mealPlan.meals
                        .map((e) => FavMealCard(
                              meal: e,
                            ))
                        .toList(),
                  );
              },
            )),
      ),
    );
  }
}

class FavMealCard extends StatelessWidget {
  final Meal meal;
  const FavMealCard({Key key, this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.2,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: EDwhite, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.only(right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Meal Image
              Container(
                height: size.height * 0.2,
                width: size.width * 0.4,
                child: Flex(direction: Axis.horizontal, children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20)),
                      child: Image.network(
                        meal.recipe.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // Meal Title

                Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 120),
                    child: Text(meal.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),
                // Meal summary
                Container(
                  constraints: BoxConstraints(maxWidth: 120),
                  child: Text(meal.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                ),
              ]),
            ],
          ),
        ));
  }
}

class MealTest {
  String title;
  int cal;
  String serving;

  MealTest(this.title, this.cal, this.serving);

  settitle(String t) {
    this.title = t;
  }

  setcal(int c) {
    cal = c;
  }

  setserv(String s) {
    serving = s;
  }
}
