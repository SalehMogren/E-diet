import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Model/UI/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Widgets/Background.dart';
import '../Widgets/Buttons.dart';

class ActivityLevelSetUp extends StatefulWidget {
  final bool edit;

  const ActivityLevelSetUp({Key key, this.edit = false}) : super(key: key);
  @override
  _ActivityLevelSetUpState createState() => _ActivityLevelSetUpState();
}

class _ActivityLevelSetUpState extends State<ActivityLevelSetUp> {
//   sedentary ( no activity )

// light ( 1 - 2 activity days/week)

// moderate (3 - 5 activity days/week)

// very active (everyday active sports)
  List<Activity> _activites = [
    Activity("Very Active", "assets/undraw_veryActive.svg"),
    Activity("Modrate", "assets/undraw_modrate.svg"),
    Activity("Light", "assets/undraw_light.svg"),
    Activity("Sedentary", "assets/undraw_sedentary.svg"),
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
          height: size.height * .9,
          width: size.width * .9,
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
                    widget.edit
                        ? 'Updating your activity level will affect on your diet'
                        : "Select Your Activity Level ",
                    style: TextStyle(
                      fontSize: widget.edit ? 20 : 28,
                      color: widget.edit ? EDpinkAcc : Colors.blue[600],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _activites
                          .map((e) => outLinedRadionButton(
                              e.text,
                              e.svg,
                              inactiveColor,
                              size.width * 0.75,
                              _activites.indexOf(e),
                              size.height * 0.13))
                          .toList(),
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  RoundedButton(
                    press: () async {
                      if (selectedIndex != -1) {
                        await user.setUserActivityLevel(
                            user.uid, selectedIndex);
                        print('Selected Index is $selectedIndex');
                        widget.edit
                            ? Navigator.pop(context)
                            : Navigator.pushReplacementNamed(
                                context, GoalSetUpRoute);
                      } else
                        setState(() {
                          error = 'Please Select A Goal';
                        });
                    },
                    text: widget.edit ? 'Save' : "Next",
                    width: size.width * .6,
                    color: widget.edit
                        ? EDlightBlueText
                        : Color.fromRGBO(49, 39, 79, 1),
                  ),
                  RoundedButton(
                    press: widget.edit
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                    text: 'Cancel',
                    color: EDpinkAcc,
                    width: size.width * .6,
                  )
                ]),
          ),
        ),
      ),
    ));
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      svg,
                      height: height * 0.6,
                    ),
                    Text(
                      text,
                      overflow: TextOverflow.visible,
                    )
                  ],
                ))));
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Activity {
  final String text, svg;

  Activity(this.text, this.svg);
}
