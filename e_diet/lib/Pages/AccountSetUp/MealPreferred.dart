import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UI/routing_constants.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealPreferredSetUp extends StatefulWidget {
  final bool edit;

  const MealPreferredSetUp({Key key, this.edit = false}) : super(key: key);
  @override
  _MealPreferredSetUpState createState() => _MealPreferredSetUpState();
}

/*void _searchMealPlan() async {
    MealPlan mealPlan = await ApiService.instance.generateMealPlan(
      targetCalories: 2000,
      diet: "None",
    );
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AppHome(mealPlan: mealPlan),
        ));
  }
*/

class _MealPreferredSetUpState extends State<MealPreferredSetUp> {
  String diet;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModle>(context);
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RoundedButton(
              text: 'Done',
              press: () async {
                // add method to sent user input to model

                Navigator.pushNamed(context, AppHomePageRoute);
              },
              color: Colors.greenAccent[400],
            ),
            DismissableCard(
                text: 'Gluten Free',
                img:
                    "https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator-asia.com/article/2020/05/05/contamination-risk-gluten-free-grain-based-foods-in-india-found-to-contain-up-to-90-times-permissible-levels/10921453-1-eng-GB/Contamination-risk-Gluten-free-grain-based-foods-in-India-found-to-contain-up-to-90-times-permissible-levels_wrbm_large.jpg",
                keyStr: 'card',
                topS: 30,
                func: (DismissDirection direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Gluten Free');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Ketogenic',
                img:
                    "https://res.cloudinary.com/grohealth/image/upload/v1583764734/DCUK/Content/Ketogenic-Diet.png",
                keyStr: 'card 1',
                topS: 25,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Ketogenic');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Lacto-Vegetarian',
                img:
                    'https://image.shutterstock.com/image-photo/closeup-signboard-text-ovolacto-vegetarian-260nw-344951654.jpg',
                keyStr: 'card 2',
                topS: 20,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Lacto-Vegetarian');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Ovo-Vegetarian',
                img:
                    'https://miro.medium.com/max/1000/1*dicP0hFwfr1w-0-3Qcuz0Q.jpeg',
                keyStr: 'card 3',
                topS: 15,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Ovo-Vegetarian');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Vegan',
                img:
                    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/healhty-vegan-lunch-bowl-avocado-quinoa-sweet-royalty-free-image-893716434-1562014604.jpg',
                keyStr: 'card 4',
                topS: 10,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Vegan');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Pescetarian',
                img:
                    'https://universityhealthnews.com/media/dreamstime_s_2605363.jpg',
                keyStr: 'card 5',
                topS: 5,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Pescetarian');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Paleo',
                img:
                    'https://i0.wp.com/post.healthline.com/wp-content/uploads/2019/11/chicken-burger-salad-fruit-1296x728-header-1296x728.jpg?w=1155&h=1528',
                keyStr: 'card 6',
                topS: 0,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Paleo');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Primal',
                img:
                    'https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/320/320516/primal-diet.jpg?w=1155&h=1541',
                keyStr: 'card 7',
                topS: 0,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Primal');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
                  } else {
                    print('left');
                  }
                }),
            DismissableCard(
                text: 'Whole30',
                img:
                    'https://cdn.chiroeco.com/wp-content/uploads/2018/05/whole30.jpg',
                keyStr: 'card 8',
                topS: 0,
                func: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('right');
                    user.setdiet('Whole30');
                    print(user.diet.toString());
                    Navigator.pushNamed(context, AppHomePageRoute);
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
                    : 'Swipe Right If You Prefer This Diet, Left Otherwise',
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
