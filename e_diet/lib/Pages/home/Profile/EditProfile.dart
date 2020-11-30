import 'package:e_diet/Model/UI/validators.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Pages/Widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Widgets/InputFeiled.dart';
import '../../Widgets/Buttons.dart';
import '../../Widgets/Background.dart';
import '../../../Model/UI/Colors.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

    return FutureBuilder<UserModle>(
        future: user.fetchData(),
        builder: (context, AsyncSnapshot<UserModle> snapshot) {
          if (snapshot.hasData)
            return Scaffold(
              body: Background(
                // color1: Colors.transparent,
                // color2: Colors.transparent,
                // color3: Colors.transparent,
                // color4: Colors.transparent,
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height * .95,
                    width: size.width * .85,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: EDwhite.withOpacity(1),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Diet Info
                            Text(
                              "Caution ! Changing Your Info Will Result On Diet Changes As Well",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // age
                            TextFieldContainer(
                              color: EDwhite,
                              child: RoundedInputField(
                                validator: AgeValidator.validate,
                                onChanged: (value) {
                                  setState(() => age = int.parse(value));
                                },
                                hintText: snapshot.data.age.toString() + 'yr',
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
                                hintText:
                                    snapshot.data.weight.toString() + 'kg',
                                icon: Icons.assignment,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            // height

                            TextFieldContainer(
                              child: RoundedInputField(
                                hintText:
                                    snapshot.data.height.toString() + 'cm',
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
                                              color: Colors.black87,
                                              fontSize: 18),
                                        )
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.all(5),
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
                                              color: Colors.black87,
                                              fontSize: 18),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                            ),

                            //submit button
                            RoundedButton(
                              width: size.width * .6,
                              text: "Save",
                              color: EDlightBlueText,
                              press: () async {
                                if (_formKey.currentState.validate()) {
                                  if (_gnder != ' ') {
                                    user.setUserHealth(
                                        user.uid, age, weight, height, _gnder);
                                    Navigator.pop(context);
                                  } else
                                    setState(() {
                                      error = "Select Gender";
                                    });
                                }
                                print(snapshot.data.info);
                              },
                            ),
                            RoundedButton(
                              width: size.width * .6,
                              text: "Cancel",
                              color: Colors.pinkAccent[400],
                              press: () {
                                Navigator.pop(context);
                              },
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            );
          else
            return Loading();
        });
  }
}
