import 'package:e_diet/Model/UI/Colors.dart';
import 'package:e_diet/Model/UI/routing_constants.dart';
import 'package:e_diet/Model/UI/validators.dart';
import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:e_diet/Pages/Widgets/Buttons.dart';
import 'package:e_diet/Pages/Widgets/InputFeiled.dart';
import 'package:e_diet/Pages/Widgets/loading.dart';
import 'package:flutter/material.dart';
import '../../../Model/Services/Auth.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final AuthService _auth = AuthService();
  String password = '';
  String password2 = '';
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
                        "Changeing The password will have to make to login back agian",
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
                        child: RoundedPasswordField(
                          validator: PasswordValidator.validate,
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          hintText: "New Password",
                          color: EDPurple0,
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
                          hintText: "Confirm New Password",
                          color: EDPurple0,
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
                        color: EDdarkPurple,
                        width: size.width * 0.5,
                        text: 'Change',
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.changePass(password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply a valid Pass';
                                loading = false;
                                _autoValidate = true;
                              });
                            } else
                              Navigator.popAndPushNamed(
                                  context, WelcomeViewRoute);
                          }
                        },
                      ),
                      RoundedButton(
                        text: 'Cancel',
                        color: EDpinkAcc,
                        width: size.width * 0.5,
                        press: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
