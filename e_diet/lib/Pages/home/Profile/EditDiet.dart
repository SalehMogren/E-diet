import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Model/routing_constants.dart';
import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import 'package:e_diet/Pages/Widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditGoal extends StatefulWidget {
  @override
  _EditGoalState createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  List<Goal> _goals = [
    Goal("Gain Weight", "assets/gain_undraw.svg"),
    Goal("Maintain Weight", "assets/maintain_undraw.svg"),
    Goal("Lose Weight", "assets/Lose_undraw.svg"),
  ];
  String error = '';

  int selectedIndex = -1;
  Color activeColor = EDPurple0;
  Color inactiveColor = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserModle>(context);

    return FutureBuilder<UserModle>(
        future: user.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Background(
                  child: SingleChildScrollView(
                child: Container(
                  height: size.height * .9,
                  width: size.width * .85,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Changing The Goal Will Result A Change On Your Diet As Well",
                            style: TextStyle(fontSize: 22, color: EDpinkAcc),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            width: size.width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _goals
                                  .map((e) => outLinedRadionButton(
                                      e.text,
                                      e.svg,
                                      inactiveColor,
                                      size.width * 0.75,
                                      _goals.indexOf(e),
                                      size.height * 0.15))
                                  .toList(),
                            ),
                          ),
                          RoundedButton(
                            press: () async {
                              if (selectedIndex != -1) {
                                await user.setUserGoal(user.uid, selectedIndex);
                                print('Selected Index is $selectedIndex');
                                Navigator.pushReplacementNamed(
                                    context, AppHomePageRoute);
                              } else
                                setState(() {
                                  error = 'Please Select A Goal';
                                });
                            },
                            text: "Save",
                            width: size.width * .6,
                            color: EDlightBlueText,
                          ),
                          RoundedButton(
                            text: 'Cancel',
                            color: EDpinkAcc,
                            width: size.width * 0.6,
                            press: () => Navigator.pop(context),
                          )
                        ]),
                  ),
                ),
              )),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget outLinedRadionButton(String text, String svg, Color txtColor,
      double width, int index, double height) {
    return Container(
        padding: EdgeInsets.all(10.0),
        height: height,
        width: width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                borderSide: BorderSide(
                    width: 3,
                    color:
                        selectedIndex == index ? activeColor : inactiveColor),
                onPressed: () => changeIndex(index),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SvgPicture.asset(
                      svg,
                      height: height * 0.6,
                    ),
                    Text(text)
                  ],
                ))));
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Goal {
  final String text, svg;

  Goal(this.text, this.svg);
}
