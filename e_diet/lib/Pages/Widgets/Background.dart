import 'package:flutter/material.dart';
import '../../Model/UI/Colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color color1, color2, color3, color4;
  const Background({
    Key key,
    @required this.child,
    this.color1 = ELightBlue0,
    this.color2 = ELightBlue1,
    this.color3 = ELightPurple0,
    this.color4 = EDPurple0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            color1,
            color2,
            color3,
            color4,
          ],
        ),
      ),
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
