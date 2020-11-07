import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/Services/Auth.dart';
import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Pages/Widgets/InputFeiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Buttons.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
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
            children: <Widget>[
              //Day swithcer Widget and Calories
              DiaryHeader(),
              //Section Widgets
              SectionMeals(
                title: 'Breakfast',
                meals: mealsBreakFast,
              ),
              SectionMeals(
                title: 'Lunch',
                meals: mealsBreakFast,
              ),

              // Complete Diary Button
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryHeader extends StatefulWidget {
  const DiaryHeader({
    Key key,
  }) : super(key: key);

  @override
  _DiaryHeaderState createState() => _DiaryHeaderState();
}

class _DiaryHeaderState extends State<DiaryHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: double.infinity,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), side: BorderSide.none),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
                      onPressed: () {},
                    ),
                    Text(
                      'Today',
                      style: TextStyle(color: ELightBlue1, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _numberAndText('1700', Colors.black, 'Goal'),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                  _numberAndText('1300', Colors.black, 'Food'),
                  Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                  _numberAndText('300', Colors.black, 'Exersice'),
                  Text(
                    '=',
                    style: TextStyle(fontSize: 20),
                  ),
                  _numberAndText('800', Colors.greenAccent, 'Remaining'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberAndText(String number, Color color, String txt) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            number,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          )
        ],
      ),
    );
  }
}

class SectionMeals extends StatefulWidget {
  @required
  final String title;
  final List<MealTest> meals;
  const SectionMeals({Key key, this.title, this.meals}) : super(key: key);

  @override
  _SectionMealsState createState() => _SectionMealsState();
}

class _SectionMealsState extends State<SectionMeals> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        height: size.height / widget.meals.length / .5,
        width: double.infinity,
        child: Card(
          color: EDwhite,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), side: BorderSide.none),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Title Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: EDPurple0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 20,
                          color: EDwhite,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      _calcTut(widget.meals),
                      style: TextStyle(fontSize: 18, color: EDwhite),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Column(
                  children:
                      widget.meals.map((e) => _mealTile(e, context)).toList(),
                ),
              )
            ],
          ),
        ));
  }

  Widget _mealTile(MealTest e, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: size.height * 0.6,
                    width: size.width * 0.6,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldContainer(
                          color: EDwhite,
                          child: RoundedInputField(
                            onChanged: (value) {
                              setState(() {
                                e.settitle(value);
                              });
                            },
                            icon: Icons.text_fields,
                            hintText: 'Title',
                          ),
                        ),
                        TextFieldContainer(
                          color: EDwhite,
                          child: RoundedInputField(
                            onChanged: (value) {
                              setState(() {
                                e.setcal(int.parse(value));
                              });
                            },
                            hintText: 'Cal',
                            icon: Icons.text_fields,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        TextFieldContainer(
                          color: EDwhite,
                          child: RoundedInputField(
                            onChanged: (value) {
                              setState(() {
                                e.setserv(value);
                              });
                            },
                            hintText: 'Servings',
                            icon: Icons.text_fields,
                          ),
                        )
                      ],
                    ),
                  ),
                ));
        print('test');
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _textAndText(e.title, Colors.black, e.serving),
            Text(
              e.cal.toString(),
              style: TextStyle(
                  color: EDPurple0, fontSize: 18, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }

  Widget _textAndText(String txtTitle, Color color, String txt) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            txtTitle,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
          )
        ],
      ),
    );
  }

  String _calcTut(List<MealTest> meals) {
    int calcounter = 0;
    meals.map((e) => calcounter += e.cal);
    print(calcounter);
    return calcounter.toString();
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
