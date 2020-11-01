import 'package:e_diet/Model/UserM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../Widgets/Background.dart';
import '../Widgets/Buttons.dart';
import '../../Model/UI/routing_constants.dart';
import '../../Model/UI/Colors.dart';

class GoalSetup extends StatefulWidget {
  @override
  _GoalSetupState createState() => _GoalSetupState();
}

class _GoalSetupState extends State<GoalSetup> {
  List<Goal> _goals = [
    Goal("Gain Weight", "assets/gain_undraw.svg"),
    Goal("Maintain", "assets/maintain_undraw.svg"),
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

    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
        child: Container(
          height: size.height * .8,
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
                    "Your Goal ?",
                    style: TextStyle(fontSize: 28, color: Colors.blue[600]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _goals
                          .map((e) => outLinedRadionButton(
                              e.text,
                              e.svg,
                              inactiveColor,
                              size.width * 0.8,
                              _goals.indexOf(e),
                              size.height * 0.15))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
                  RoundedButton(
                    press: () async {
                      if (selectedIndex != -1) {
                        await user.setUserGoal(user.uid, selectedIndex);
                        print('Selected Index is $selectedIndex');
                        Navigator.pushReplacementNamed(
                            context, MealPrefSetUpRoute);
                      } else
                        setState(() {
                          error = 'Please Select A Goal';
                        });
                    },
                    text: "Next",
                    width: size.width * .6,
                    color: Color.fromRGBO(49, 39, 79, 1),
                  )
                ]),
          ),
        ),
      )),
    );
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
                    width: 4,
                    color:
                        selectedIndex == index ? activeColor : inactiveColor),
                onPressed: () => changeIndex(index),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
