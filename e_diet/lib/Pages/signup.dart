import 'package:flutter/material.dart';

class SignUpContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Container(
          height: size.height * .8,
          width: size.width * .85,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
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
                Divider(
                  endIndent: size.width * .0,
                  indent: size.width * .0,
                  thickness: 1,
                ),
                RoundedButton(
                  color: Colors.teal[400],
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
              ]),
        ),
      ),
    );
  }
// widget of the contact info form

// widget of user diet info

}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.teal[400],
            Colors.blue,
          ])),
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      width: size.width * 0.75,
      height: size.height * .08,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  final Function onSubmitted;

  final TextInputType keyboardType;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        cursorColor: Colors.orange,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.teal[400],
            size: 28,
          ),
          hintStyle: TextStyle(fontSize: 14),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class RoundButtonGoogle extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundButtonGoogle({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      autofocus: true,
      splashColor: Colors.blue,
      onPressed: press,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(
        color: Colors.blue[300],
        width: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            )
          ],
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
          padding: EdgeInsets.all(0),
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
                RoundedInputField(
                  hintText: "Age",
                  icon: Icons.assignment_ind,
                  keyboardType: TextInputType.number,
                ),
                // weight

                RoundedInputField(
                  hintText: "Weight",
                  icon: Icons.assignment,
                  keyboardType: TextInputType.number,
                ),
                // height

                RoundedInputField(
                  hintText: "Height",
                  icon: Icons.accessibility,
                  keyboardType: TextInputType.number,
                ),

                // your goal
                Text("YourGoal ?"),
                SizedBox(
                  height: 25,
                ),
                //submit button
                RoundedButton(
                  text: "Submit",
                  color: Colors.teal[400],
                  press: () {},
                ),
              ]),
        ),
      ),
    );
  }
// widget of the contact info form

// widget of user diet info

}
