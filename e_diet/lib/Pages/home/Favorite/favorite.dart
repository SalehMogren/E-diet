import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/Services/Auth.dart';
import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Pages/Widgets/InputFeiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Buttons.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Diary',
            textAlign: TextAlign.center,
            style: TextStyle(color: EDPurple0),
          ),
        ),
        centerTitle: true,
        leading: null,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
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
