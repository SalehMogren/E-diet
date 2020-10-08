import 'package:e_diet/Model/UserM.dart';
import '../Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/Background.dart';
import 'AccountSetUp/login.dart';
import 'AccountSetUp/signup.dart';
import 'package:flutter_svg/svg.dart';
import 'Widgets/Buttons.dart';
import '../Model/UI/Colors.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModle>(context);

    if (user != null) {
      return AppHome();
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
                color: EDdarkPurple,
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
                textColor: EDdarkPurple,
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
