// File For Reusing Validators Of User Input Accross The App

class EmailValidator {
  static String validate(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    return value.length < 6 ? 'Enter a password 6+ chars long' : null;
  }
}

class AgeValidator {
  static String validate(String value) {
    return (value.length >= 2 &&
            (int.parse(value) < 100 && int.parse(value) > 4))
        ? null
        : 'Enter Valid Age ';
  }
}

class WeightValidator {
  static String validate(String value) {
    return (value.length >= 2 &&
            (double.parse(value) <= 120 && double.parse(value) >= 20))
        ? null
        : 'Enter Valid Weight 20kg -120kg';
  }
}

class HeightValidator {
  static String validate(String value) {
    return (value.length >= 2 &&
            (double.parse(value) <= 250 && double.parse(value) >= 70))
        ? null
        : 'Enter Valid Height 80cm - 240cm';
  }
}
