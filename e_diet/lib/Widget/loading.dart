import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF5B16D0),
      child: Center(
        child: SpinKitPumpingHeart(
          color: Color(0xFF3594DD),
          size: 50.0,
        ),
      ),
    );
  }
}
