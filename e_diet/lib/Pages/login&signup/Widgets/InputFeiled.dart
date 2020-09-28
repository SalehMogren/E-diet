import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10.0),
      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor, color, txtColor;
  final Function onSubmitted, validator;

  final TextInputType keyboardType;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.validator,
    this.iconColor = const Color(0xFF5B16D0),
    this.color,
    this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      style: TextStyle(
        color: txtColor,
      ),
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.orange,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        icon: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  final Function onSubmitted, validator;
  final String hintText;

  final Color color, txtColor, cursorColor;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.color,
    this.txtColor,
    this.cursorColor,
    this.onSubmitted,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: txtColor,
      ),
      validator: validator,
      obscureText: true,
      onChanged: onChanged,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        hintText: hintText,
        icon: Icon(
          Icons.lock,
          color: color,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: color,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
