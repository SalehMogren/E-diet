import 'package:flutter/material.dart';
import 'Widgets/Background.dart';
import 'Widgets/Buttons.dart';
import 'Widgets/InputFeiled.dart';
import '../profile.dart';

class SignUpContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
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
                child: RoundedInputField(
                  hintText: "Name",
                  icon: Icons.person,
                  onChanged: (value) {},
                ),
              ),
              TextFieldContainer(
                child: RoundedInputField(
                  hintText: "Email",
                  icon: Icons.email,
                  onChanged: (value) {},
                ),
              ),
              TextFieldContainer(
                child: RoundedInputField(
                  hintText: "Password",
                  icon: Icons.lock,
                  onChanged: (value) {},
                ),
              ),
              TextFieldContainer(
                child: RoundedInputField(
                  hintText: "Confirm Password",
                  icon: Icons.lock,
                  onChanged: (value) {},
                ),
              ),
              // Divider(
              //   endIndent: size.width * .0,
              //   indent: size.width * .0,
              //   thickness: 1,
              //   color: Colors.white,
              // ),
              RoundedButton(
                color: Color.fromRGBO(49, 39, 79, 1),
                width: size.width * 0.5,
                text: 'Sign Up',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpDietInfo(),
                      ));
                },
              ),
              RoundButtonGoogle(
                text: "Signup With Google",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpDietInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Container(
          height: size.height * .8,
          width: size.width * .85,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Diet Info
                Text(
                  "Enter Your Health Info ",
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // age
                TextFieldContainer(
                  child: RoundedInputField(
                    hintText: "Age",
                    icon: Icons.assignment_ind,
                    keyboardType: TextInputType.number,
                  ),
                ),
                // weight

                TextFieldContainer(
                  child: RoundedInputField(
                    hintText: "Weight",
                    icon: Icons.assignment,
                    keyboardType: TextInputType.number,
                  ),
                ),
                // height

                TextFieldContainer(
                  child: RoundedInputField(
                    hintText: "Height",
                    icon: Icons.accessibility,
                    keyboardType: TextInputType.number,
                  ),
                ),

                // your goal
                Text("YourGoal ?"),
                SizedBox(
                  height: 25,
                ),
                //submit button
                RoundedButton(
                  text: "Submit",
                  color: Color.fromRGBO(49, 39, 79, 1),
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ));
                  },
                ),
              ]),
        ),
      ),
    );
  }
// widget of the contact info form

// widget of user diet info

}
