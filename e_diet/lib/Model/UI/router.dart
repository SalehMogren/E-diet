import 'package:e_diet/Pages/AccountSetUp/MealPreferred.dart';
import 'package:flutter/material.dart';
import '../../Pages/Welcome.dart';
import '../../Pages/AccountSetUp/HealthSetUp.dart';
import '../../Pages/AccountSetUp/goalSetup.dart';
import 'routing_constants.dart';
import '../../Pages/home.dart';
import '../../Pages/AccountSetUp/activityLevel.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing

  switch (settings.name) {
    case AppHomePageRoute:
      return MaterialPageRoute(builder: (context) => AppHome());
    case WelcomeViewRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case HealthSetUpRoute:
      return MaterialPageRoute(builder: (context) => HealthSetUp());
    case GoalSetUpRoute:
      return MaterialPageRoute(builder: (context) => GoalSetup());
    case MealPrefSetUpRoute:
      return MaterialPageRoute(builder: (context) => MealPreferredSetUp());
    case EditMealPrefSetUpRoute:
      return MaterialPageRoute(
          builder: (context) => MealPreferredSetUp(edit: true));

    case ActivityLevelSetUpRoute:
      return MaterialPageRoute(builder: (context) => ActivityLevelSetUp());
    case EditActivityLevelSetUpRoute:
      return MaterialPageRoute(
          builder: (context) => ActivityLevelSetUp(edit: true));

    default:
      return MaterialPageRoute(builder: (context) => AppHome());
  }
}
