import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login&signup/Widgets/Background.dart';
import 'login&signup/login.dart';
import 'login&signup/signup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_diet/Pages/login&signup/Widgets/Buttons.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModle>(context);

    if (user != null) {
      return ProfilePage();
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome To E-Diet",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "assets/undraw_breakfast_psiw.svg",
                height: size.height * 0.20,
              ),
              SizedBox(
                height: 40,
              ),
              RoundedButton(
                color: Color.fromRGBO(49, 39, 79, 1),
                text: "Login",
                width: size.width * .5,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
              ),
              RoundedButton(
                color: Colors.white,
                text: "SignUp",
                textColor: Color.fromRGBO(49, 39, 79, 1),
                width: size.width * .5,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpContactInfo(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
