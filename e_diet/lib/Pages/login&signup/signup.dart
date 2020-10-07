import 'package:e_diet/Model/Auth.dart';
import 'package:e_diet/Widget/loading.dart';
import 'package:flutter/material.dart';
import 'Widgets/Background.dart';
import 'Widgets/Buttons.dart';
import 'Widgets/InputFeiled.dart';
import '../../Model/routing_constants.dart';

class SignUpContactInfo extends StatefulWidget {
  @override
  _SignUpContactInfoState createState() => _SignUpContactInfoState();
}

class _SignUpContactInfoState extends State<SignUpContactInfo> {
  final AuthService _auth = AuthService();
  //text field state
  String email = '';
  String password = '';
  String password2 = '';
  String name = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Scaffold(
            body: Background(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Form(
                  // ignore: deprecated_member_use
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFieldContainer(
                        color: Colors.white,
                        child: RoundedInputField(
                          validator: (value) =>
                              value.length < 2 ? 'Enter your name' : null,
                          onChanged: (value) {
                            setState(() => name = value);
                          },
                          hintText: "Name",
                          icon: Icons.person,
                        ),
                      ),
                      TextFieldContainer(
                        color: Colors.white,
                        child: RoundedInputField(
                          validator: validateEmail,
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          hintText: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      TextFieldContainer(
                        color: Colors.white,
                        child: RoundedPasswordField(
                          validator: (value) => value.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          hintText: "Password",
                          color: Color(0xFF5B16D0),
                        ),
                      ),
                      TextFieldContainer(
                        color: Colors.white,
                        child: RoundedPasswordField(
                          onChanged: (value) {
                            setState(() => password2 = value);
                          },
                          validator: (value) => password2 != password
                              ? 'Passord\t Doesnt Match '
                              : null,
                          hintText: "Confirm Password",
                          color: Color(0xFF5B16D0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ),
                      RoundedButton(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        width: size.width * 0.5,
                        text: 'Sign Up',
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, name);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply a valid email';
                                loading = false;
                                _autoValidate = true;
                              });
                            } else
                              Navigator.pushReplacementNamed(
                                  context, HealthSetUpRoute);
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      RoundButtonGoogle(
                        textColor: Color(0xFF3594DD),
                        width: size.width * 0.5,
                        color: Colors.white,
                        text: "Google",
                        press: () => _auth.signInWithGoogle().then((value) =>
                            value
                                ? Navigator.pushReplacementNamed(
                                    context, HealthSetUpRoute)
                                : Navigator.pushReplacementNamed(
                                        context, ProfilePageRoute)
                                    .catchError((onError) =>
                                        print('Failed to Auth $onError'))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

// TODO: implement goal set up page
