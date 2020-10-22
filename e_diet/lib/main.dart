import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Model/Auth.dart';
import 'package:e_diet/Model/screen.dart';
import 'package:e_diet/Pages/AccountSetUp/MealPreferred.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/router.dart' as router;
import 'Model/routing_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModle>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: router.generateRoute,
        initialRoute: WelcomeViewRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
