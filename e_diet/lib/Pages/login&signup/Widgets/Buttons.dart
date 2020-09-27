import 'dart:ffi';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor = Colors.white,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .08,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class RoundButtonGoogle extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width;
  const RoundButtonGoogle({
    Key key,
    this.text,
    this.press,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .08,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          color: color,
          onPressed: press,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class RoundButtonGoogle extends StatelessWidget {
//   final String text;
//   final Function press;
//   final Color color, textColor;
//   final double width;
//   const RoundButtonGoogle({
//     Key key,
//     this.text,
//     this.press,
//     this.color = Colors.white,
//     this.textColor = Colors.white,
//     this.width,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * .08,
//       width: width,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: FlatButton(
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//           color: color,
//           onPressed: press,
//           child: Text(
//             text,
//             style: TextStyle(color: textColor),
//           ),
//         ),
//       ),
//     );
//   }
//   //   autofocus: true,
//   //   splashColor: Colors.blue,
//   //   onPressed: press,
//   //   shape: RoundedRectangleBorder(
//   //     borderRadius: BorderRadius.circular(15),
//   //   ),
//   //   highlightElevation: 0,
//   //   borderSide: BorderSide(
//   //     color: Colors.blue[300],
//   //     width: 2,
//   //   ),
//   //   child: Padding(
//   //     padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
//   //     child: Row(
//   //       mainAxisSize: MainAxisSize.min,
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: <Widget>[
//   //         Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
//   //         Padding(
//   //           padding: const EdgeInsets.only(left: 10),
//   //           child: Text(
//   //             text,
//   //             style: TextStyle(
//   //               fontSize: 16,
//   //               color: Colors.blue,
//   //             ),
//   //           ),
//   //         )
//   //       ],
//   //     ),
//   //   ),
//   // );

// }
