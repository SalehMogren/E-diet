import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/routing_constants.dart';
import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import 'package:flutter/material.dart';

class MealPreferredSetUp extends StatefulWidget {
  final bool edit;

  const MealPreferredSetUp({Key key, this.edit = false}) : super(key: key);
  @override
  _MealPreferredSetUpState createState() => _MealPreferredSetUpState();
}

class _MealPreferredSetUpState extends State<MealPreferredSetUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RoundedButton(
              text: 'Done',
              press: () {
                // add method to sent user input to model
                Navigator.popAndPushNamed(context, AppHomePageRoute);
              },
              color: Colors.greenAccent[400],
            ),
            DismissableCard(
                text: '1',
                img:
                    "https://hips.hearstapps.com/delish/assets/17/31/1501791674-delish-chicken-curry-horizontal.jpg",
                keyStr: 'card',
                topS: 30,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: '2',
                img:
                    "https://www.expatica.com/app/uploads/sites/5/2020/03/Boeuf-bourguignon-1920x1080.jpg",
                keyStr: 'card 1',
                topS: 20,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: '3',
                img:
                    'https://thumbor.thedailymeal.com/8snKtQlPGA9m6x6BVEfr6RAahf4=/870x565/https://www.thedailymeal.com/sites/default/files/slideshows/2414/2222795/spinach_lasagna.jpg',
                keyStr: 'card 2',
                topS: 10,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                  } else {
                    print('left');
                  }
                }),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 90),
              child: Text(
                widget.edit
                    ? 'Update your meal prefrence '
                    : 'Swipe Right If You Prefer This Meal, Left Otherwise',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 50),
              child: RoundedButton(
                text: 'Cancel',
                color: EDpinkAcc,
                press: widget.edit
                    ? () {
                        Navigator.pop(context);
                      }
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DismissableCard extends StatelessWidget {
  const DismissableCard({
    Key key,
    @required this.text,
    @required this.img,
    @required this.topS,
    @required this.func,
    this.keyStr,
  }) : super(key: key);

  final String text;
  final String img;
  final String keyStr;
  final double topS;
  final Function func;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.only(top: topS, bottom: 0),
        height: size.height * .55,
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // color: Color.fromARGB(250, 112, 19, 179),
          child: Column(
            children: <Widget>[
              Hero(
                tag: "imageTag" + keyStr,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      img,
                      width: size.width * .8,
                      height: size.height * .4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.purple,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onDismissed: func,
    );
  }
}
