import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/Services/DataBase.dart';
import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'diaryWidgets.dart';
import 'package:intl/intl.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var modle = Provider.of<UserModle>(context);
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
      body: FutureBuilder(
          future: modle.fetchData(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting)
            //   return Text('Loading..');
            if (snapshot.hasError) return Text('Error Happend');

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: <Widget>[
                    //Day swithcer Widget and Calories
                    Consumer<UserModle>(
                        builder: (context, value, child) => DiaryHeader(
                              dateTime: date,
                              prevDay: () {
                                moveDate('backward', value);
                                print('Current Date is ${dateFormater(date)}');
                              },
                              forwardDay: () {
                                moveDate('forward', value);
                              },
                              goalCal: value.nutrition.calories.toInt(),
                              eatenCal: value.diary[dateFormater(date)] == null
                                  ? 0
                                  : calcTotalEatenCal(
                                      value.diary[dateFormater(date)].values),
                            )),
                    //Section Widgets
                    Consumer<UserModle>(
                      builder: (context, value, child) => SectionMeals(
                        delete: () {
                          if (value.diary[dateFormater(date)] != null)
                            value.removeMealFromDiary(
                                value.diary[dateFormater(date)]['Breakfast'],
                                dateFormater(date),
                                'Breakfast');
                        },
                        mealExist: value.diary[dateFormater(date)] == null
                            ? false
                            : value.diary[dateFormater(date)]
                                .containsKey('Breakfast'),
                        title: 'Breakfast',
                        meal: value.diary[dateFormater(date)] == null
                            ? null
                            : value.diary[dateFormater(date)]['Breakfast'],
                      ),
                    ),
                    Consumer<UserModle>(
                      builder: (context, value, child) => SectionMeals(
                        mealExist: value.diary[dateFormater(date)] == null
                            ? false
                            : value.diary[dateFormater(date)]
                                .containsKey('Lunch'),
                        title: 'Lunch',
                        meal: value.diary[dateFormater(date)] == null
                            ? null
                            : value.diary[dateFormater(date)]['Lunch'],
                      ),
                    ),
                    Consumer<UserModle>(
                      builder: (context, value, child) => SectionMeals(
                        mealExist: value.diary[dateFormater(date)] == null
                            ? false
                            : value.diary[dateFormater(date)]
                                .containsKey('Dinner'),
                        title: 'Dinner',
                        meal: value.diary[dateFormater(date)] == null
                            ? null
                            : value.diary[dateFormater(date)]['Dinner'],
                      ),
                    ),

                    // Complete Diary Button
                  ],
                ),
              ),
            );
          }),
    );
  }

  String dateFormater(DateTime changeDate) {
    return "${DateFormat("M-d-y").format(changeDate)}";
  }

  int calcTotalEatenCal(Iterable<Meal> values) {
    int total = 0;
    values.forEach((element) {
      total += element.recipe.calories.toInt();
    });
    return total;
  }

  void moveDate(String dierction, UserModle value) {
    DateTime temp = date;

    if (dierction == 'forward') {
      // print('temp date ${dateFormater(temp.add(Duration(days: 2)))}');
      if (value.diary.containsKey(dateFormater(temp.add(Duration(days: 1)))))
        setState(() {
          date = date.add(Duration(days: 1));
        });
    }
    if (dierction == 'backward') {
      if (value.diary
          .containsKey(dateFormater(temp.subtract(Duration(days: 1)))))
        setState(() {
          date = date.subtract(Duration(days: 1));
        });
    }
  }
}
