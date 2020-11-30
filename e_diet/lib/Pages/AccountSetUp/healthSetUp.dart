import 'package:e_diet/Model/UI/validators.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Model/UI/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/Background.dart';
import '../Widgets/Buttons.dart';
import '../Widgets/InputFeiled.dart';

class HealthSetUp extends StatefulWidget {
  @override
  _HealthSetUpState createState() => _HealthSetUpState();
}

class _HealthSetUpState extends State<HealthSetUp> {
  final _formKey = GlobalKey<FormState>();
  String error = '';

  int age;

  double weight;

  double height;

  String _gnder = ' ';
  Color activeColor = Color(0xFF5B16D0);
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Diet Info
                    Text(
                      "Enter Your Health Info ",
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // age
                    TextFieldContainer(
                      child: RoundedInputField(
                        validator: AgeValidator.validate,
                        onChanged: (value) {
                          setState(() => age = int.parse(value));
                        },
                        hintText: "Age",
                        icon: Icons.assignment_ind,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // weight

                    TextFieldContainer(
                      child: RoundedInputField(
                        validator: WeightValidator.validate,
                        onChanged: (value) {
                          setState(() => weight = double.parse(value));
                        },
                        hintText: "Weight in Kg",
                        icon: Icons.assignment,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    // height

                    TextFieldContainer(
                      child: RoundedInputField(
                        hintText: "Height in CM",
                        validator: HeightValidator.validate,
                        onChanged: (value) {
                          setState(() => height = double.parse(value));
                        },
                        icon: Icons.accessibility,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  value: "Male",
                                  groupValue: _gnder,
                                  onChanged: (value) {
                                    setState(() {
                                      _gnder = value;
                                    });
                                  },
                                  activeColor: activeColor,
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18),
                                )
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  value: "Female",
                                  groupValue: _gnder,
                                  onChanged: (value) {
                                    setState(() {
                                      _gnder = value;
                                    });
                                  },
                                  activeColor: activeColor,
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18),
                                )
                              ],
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ),

                    //submit button
                    RoundedButton(
                      width: size.width * .6,
                      text: "Next",
                      color: Color.fromRGBO(49, 39, 79, 1),
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          if (_gnder != ' ') {
                            user.setUserHealth(
                                user.uid, age, weight, height, _gnder);
                            Navigator.pushNamed(
                                context, ActivityLevelSetUpRoute);
                          } else
                            setState(() {
                              error = "Select Gender";
                            });
                        }
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
