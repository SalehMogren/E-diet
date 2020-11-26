import 'package:e_diet/Model/DietLogic/Meal_model.dart';
import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import 'package:e_diet/Pages/Widgets/InputFeiled.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryHeader extends StatefulWidget {
  final Function prevDay, forwardDay;
  final int goalCal, eatenCal;
  final DateTime dateTime;
  const DiaryHeader({
    Key key,
    this.prevDay,
    this.forwardDay,
    @required this.goalCal,
    @required this.eatenCal,
    @required this.dateTime,
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
                      onPressed: widget.prevDay,
                      tooltip: 'Previous Day',
                    ),
                    Text(
                      dayBasedOnDate(widget.dateTime),
                      style: TextStyle(color: ELightBlue1, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onPressed: widget.forwardDay,
                    ),
                  ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _numberAndText(
                      widget.goalCal.toString(), Colors.black, 'Goal'),
                  Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                  _numberAndText(
                      widget.eatenCal.toString(), Colors.black, 'Food'),
                  // Text(
                  //   '+',
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // _numberAndText('300', Colors.black, 'Exersice'),
                  Text(
                    '=',
                    style: TextStyle(fontSize: 20),
                  ),
                  _numberAndText((widget.goalCal - widget.eatenCal).toString(),
                      Colors.greenAccent, 'Remaining'),
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

  String dayBasedOnDate(DateTime dateTime) {
    DateTime temp = DateTime.now();
    Duration diffrenceDays = temp.difference(dateTime);
    if (diffrenceDays.inDays == 0)
      return 'Today';
    else if (diffrenceDays.inDays == 1)
      return 'Yesterday';
    else if (diffrenceDays.inDays == -1)
      return 'Tomorrow';
    else
      return "${DateFormat("M-d-y").format(dateTime)}";
  }
}

class SectionMeals extends StatefulWidget {
  final String title;
  final Meal meal;
  final bool mealExist;
  final Function delete;
  const SectionMeals(
      {Key key,
      @required this.title,
      @required this.meal,
      @required this.mealExist,
      this.delete})
      : super(key: key);

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
        height: size.height * 0.25,
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
                          widget.mealExist
                              ? (widget.meal.recipe.calories).toString()
                              : '0',
                          style: TextStyle(fontSize: 18, color: EDwhite),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Column(
                      children: widget.mealExist
                          ? [_mealTile(widget.meal, context)]
                          : [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Add Meal',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: EDPurple0,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                      Text(
                                        '+',
                                        style: TextStyle(
                                            color: EDPurple0,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                    ),
                  )
                ])));
  }

  Widget _mealTile(Meal e, BuildContext context) {
    String title = e.title;
    int cal = e.recipe.calories.toInt();
    String serving = e.servings.toString();
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.0),
        color: Colors.redAccent,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // ignore: unnecessary_statements
          widget.delete;
        }
      },
      child: GestureDetector(
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
                          // TextFieldContainer(
                          //   color: EDwhite,
                          //   child: RoundedInputField(
                          //     onChanged: (value) {
                          //       setState(() {
                          //         e.settitle(value);
                          //       });
                          //     },
                          //     icon: Icons.text_fields,
                          //     hintText: 'Title',
                          //   ),
                          // ),
                          // TextFieldContainer(
                          //   color: EDwhite,
                          //   child: RoundedInputField(
                          //     onChanged: (value) {
                          //       setState(() {
                          //         e.setcal(int.parse(value));
                          //       });
                          //     },
                          //     hintText: 'Cal',
                          //     icon: Icons.text_fields,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40, top: 10),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),

                          Text(
                            "Calories:$cal",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Servings:$serving",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          TextFieldContainer(
                            color: EDwhite,
                            child: RoundedInputField(
                              onChanged: (value) {
                                setState(() {
                                  e.servings = int.parse(value);
                                });
                              },
                              hintText: 'Servings',
                              icon: Icons.text_fields,
                            ),
                          ),

                          RoundedButton(
                              color: EDlightBlueText,
                              text: "Done",
                              press: () {
                                Navigator.pop(context);
                              },
                              width: size.width * 0.4),
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
              _textAndText(e.title, Colors.black, e.servings.toString()),
              Text(
                e.recipe.calories.toString(),
                style: TextStyle(
                    color: EDPurple0,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
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
          Container(
            constraints: BoxConstraints(maxWidth: 180),
            child: Text(
              txtTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
          )
        ],
      ),
    );
  }
}
