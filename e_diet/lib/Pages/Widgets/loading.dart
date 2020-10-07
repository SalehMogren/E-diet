import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Background.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
