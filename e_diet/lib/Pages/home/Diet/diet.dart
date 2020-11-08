import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import '../../../Model/DietLogic/Meal_model.dart';

class Diet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();
    var modle = Provider.of<UserModle>(context);
    double _progressNum(double n1, double n2) {
      if (n1 / n2 > 1)
        return 1;
      else
        return n1 / n2;
    }

    return FutureBuilder<UserModle>(
        future: modle.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Text('Loading...');
          if (snapshot.hasError) return Text('Error');
          return Consumer<UserModle>(
            builder: (context, value, child) => Scaffold(
              backgroundColor: const Color(0xFFE9E9E9),
              body: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    height: height * 0.37,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: const Radius.circular(40),
                      ),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 40, left: 20, right: 16, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                "Hello," + value.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 26,
                                  color: Colors.black,
                                ),
                              ),
                              // trailing: ClipOval(
                              //     child: Image.network(snapshot.data.photoUrl)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                _RadialProgress(
                                  calTxt: (value.nutrition.calories.toInt() -
                                          value.nutrition.caloriesEaten.toInt())
                                      .toString(),
                                  width: width * 0.28,
                                  height: width * 0.20,
                                  progress: value.nutrition.caloriesEaten /
                                      value.nutrition.calories,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _IngredientProgress(
                                      ingredient: "Protein",
                                      progress: _progressNum(
                                          value.nutrition.proteinEaten,
                                          value.nutrition.protein),
                                      progressColor: Colors.green,
                                      leftAmount: value.nutrition.protein
                                              .toInt() -
                                          value.nutrition.proteinEaten.toInt(),
                                      width: width * 0.28,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _IngredientProgress(
                                      ingredient: "Carbs",
                                      progress: _progressNum(
                                          value.nutrition.carbsEaten,
                                          value.nutrition.carbs),
                                      progressColor: Colors.red,
                                      leftAmount: value.nutrition.carbs
                                              .toInt() -
                                          value.nutrition.carbsEaten.toInt(),
                                      width: width * 0.28,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _IngredientProgress(
                                      ingredient: "Fat",
                                      progress: _progressNum(
                                          value.nutrition.fatEaten,
                                          value.nutrition.fat),
                                      progressColor: Colors.yellow,
                                      leftAmount: value.nutrition.fat.toInt() -
                                          value.nutrition.fatEaten.toInt(),
                                      width: width * 0.28,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.39,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: height * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              left: 32,
                              right: 16,
                            ),
                            child: Text(
                              "MEALS FOR TODAY",
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  children: value.mealPlan.meals
                                      .map((e) => _MealCard(
                                            meal: e,
                                            pressAte: () {
                                              value.eat(
                                                  e,
                                                  value.mealPlan.meals
                                                      .indexOf(e));
                                              Navigator.pop(context);
                                            },
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {Key key,
      this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${leftAmount}g left"),
          ],
        ),
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;
  final String calTxt;
  const _RadialProgress(
      {Key key, this.height, this.width, this.progress, this.calTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: progress,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: calTxt,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF200087),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF200087),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatelessWidget {
  final Function pressAte;
  final Meal meal;

  const _MealCard({Key key, @required this.meal, this.pressAte})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => CustomDialog(
                  ate: pressAte,
                  image: meal.recipe.image,
                  title: meal.title,
                  description: meal.recipe.summary,
                  protein: meal.recipe.protein.toString(),
                  carbs: meal.recipe.carbs.toString(),
                  fat: meal.recipe.fat.toString(),
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 20,
          bottom: 10,
        ),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    meal.recipe.image,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text(
                          meal.dishType,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 120),
                        child: Text(meal.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      ),
                      Text(
                        "${meal.recipe.calories} kcal",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 15,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${meal.readyInMinutes} min",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: null),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText, image, protein, carbs, fat;
  final Function ate;
  CustomDialog(
      {this.title,
      this.ate,
      this.description,
      this.buttonText,
      this.image,
      this.carbs,
      this.fat,
      this.protein});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 160, bottom: 50, left: 30, right: 30),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.0),
                // TO:DO Fix Description

                Expanded(
                    child: Text(
                  description,
                  style: TextStyle(fontSize: 16),
                )),
                SizedBox(height: 24.0),
                Text(
                  "Protein: $protein g",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Carps: $carbs g",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Fat: $fat g",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RoundedButton(
                          color: EDlightBlueText,
                          text: "Ate it",
                          press: ate,
                          width: size.width * 0.4),
                      RoundedButton(
                          press: () {
                            Navigator.pop(context);
                          },
                          text: 'Don\'t Like it?',
                          color: EDpinkAcc,
                          width: size.width * 0.4),
                    ]),
              ],
            )),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 80,
              backgroundImage: NetworkImage(image),
            ))
      ],
    );
  }
}
