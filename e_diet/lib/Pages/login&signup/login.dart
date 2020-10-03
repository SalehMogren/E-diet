import 'package:e_diet/Model/Auth.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Widget/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Widgets/Background.dart';
import 'Widgets/Buttons.dart';
import 'Widgets/InputFeiled.dart';
import '../../Model/routing_constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  //text field state
  String email = '';
  String password = '';
  String password2 = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xff21254A),
            body: Background(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Hello there, \nwelcome back",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFieldContainer(
                                    child: RoundedInputField(
                                      txtColor: Colors.white,
                                      validator: (value) => value.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                      onChanged: (value) {
                                        setState(() => email = value);
                                      },
                                      hintText: "Email",
                                      icon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  TextFieldContainer(
                                    child: RoundedPasswordField(
                                      validator: (value) => value.length < 6
                                          ? 'Enter Password'
                                          : null,
                                      onChanged: (value) {
                                        setState(() => password = value);
                                      },
                                      hintText: "Password",
                                      color: Color(0xFF5B16D0),
                                      txtColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: RoundedButton(
                              text: "Login",
                              color: Color.fromRGBO(49, 39, 79, 1),
                              width: size.width * 0.5,
                              press: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Couldnn\'t sign in with provided credintials';
                                      loading = false;
                                    });
                                  } else
                                    Navigator.pushNamed(
                                        context, ProfilePageRoute);
                                }
                              },
                            ),
                          ),
                          Center(
                            child: RoundButtonGoogle(
                              textColor: Color(0xFF3594DD),
                              width: size.width * 0.5,
                              color: Colors.white,
                              text: "Google",
                              press: () async=>_auth.googleSignIn().then((dynamic user) => print(user)).catchError((e)=>print(e))
                              ,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.pink[200],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
