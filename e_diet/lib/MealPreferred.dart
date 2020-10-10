import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:flutter/material.dart';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Preferred(),
    );
  }
}

class Preferred extends StatefulWidget {
  @override
  _PreferredState createState() => _PreferredState();
}

class _PreferredState extends State<Preferred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            DismissableCard(
              '1',
              "https://www.tripsavvy.com/thmb/LTudD1VFIPILWGW5MoCsgBmhOGs=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/464741705-56a3c03d5f9b58b7d0d39809.jpg",
              'card',
              30,
              (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  print('right');
                } else {
                  print('left');
                }
              },
            ),
            DismissableCard(
              '2',
              "https://www.tripsavvy.com/thmb/LTudD1VFIPILWGW5MoCsgBmhOGs=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/464741705-56a3c03d5f9b58b7d0d39809.jpg",
              'card 1',
              20,
              (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  print('right');
                } else {
                  print('left');
                }
              },
            ),
            DismissableCard(
              '3',
              "https://www.tripsavvy.com/thmb/LTudD1VFIPILWGW5MoCsgBmhOGs=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/464741705-56a3c03d5f9b58b7d0d39809.jpg",
              'card 2',
              10,
              (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  print('right');
                } else {
                  print('left');
                }
              },
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 90),
              child: Text(
                'data',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DismissableCard(
    String text,
    String img,
    String key,
    double topS,
    Function Rfunc,
  ) {
    return Dismissible(
      key: Key('$key'),
      child: Container(
        margin: EdgeInsets.only(top: topS, bottom: 0),
        height: 400,
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // color: Color.fromARGB(250, 112, 19, 179),
          child: Column(
            children: <Widget>[
              Hero(
                tag: "imageTag",
                child: Image.network(
                  "$img",
                  width: 320.0,
                  height: 300.0,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  '$text',
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
      onDismissed: Rfunc,
    );
  }
}
