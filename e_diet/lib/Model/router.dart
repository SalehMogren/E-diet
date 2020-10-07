import 'package:flutter/material.dart';
import '../Pages/Welcome.dart';
import '../Pages/profile.dart';
import '../Pages/AccountSetUp/HealthSetUp.dart';
import '../Pages/AccountSetUp/goalSetup.dart';
import 'routing_constants.dart';
import '../Pages/home/Profile/Profile.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing

  switch (settings.name) {
    case ProfilePageRoute:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case WelcomeViewRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case HealthSetUpRoute:
      return MaterialPageRoute(builder: (context) => HealthSetUp());
    case GoalSetUpRoute:
      return MaterialPageRoute(builder: (context) => GoalSetup());

    default:
      return MaterialPageRoute(builder: (context) => ProfilePage());
  }
}
