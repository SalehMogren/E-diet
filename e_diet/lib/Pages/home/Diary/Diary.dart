import 'package:e_diet/Model/Services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Buttons.dart';

class Diary extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RoundedButton(
          text: 'Find Email',
          color: Colors.greenAccent,
          press: () =>
              print(_auth.checkUserEmailInDB().then((value) => print(value)))),
      // child: Text('Diary'),
    );
  }
}
