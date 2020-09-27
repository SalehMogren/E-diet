import 'package:flutter/material.dart';
import '../Pages/Welcome.dart';
import '../Pages/profile.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing

  switch (settings.name) {
    case ProfilePageRoute:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case WelcomeViewRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    default:
      return MaterialPageRoute(builder: (context) => ProfilePage());
  }
}
