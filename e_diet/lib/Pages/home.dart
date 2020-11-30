import 'package:e_diet/Model/Services/Auth.dart';
import 'package:e_diet/Model/UserM.dart';
import 'package:e_diet/Pages/home/Diary/Diary.dart';
import 'package:e_diet/Pages/home/Diet/diet.dart';
// import 'package:e_diet/Pages/home/Favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'home/Profile/Profile.dart';
import '../Model/UI/Colors.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Diet(),
    Diary(),
    // Favorite(),
    ProfilePageNew(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModle(AuthService().userUid()),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SafeArea(
          child: bottomeNav(),
        ),
      ),
    );
  }

  Widget bottomeNav() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ],
          borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GNav(
              gap: 10,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey[800],
              tabs: [
                GButton(
                  backgroundColor: ELightBlue0,
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  backgroundColor: ELightPurple0,
                  icon: LineIcons.book,
                  text: 'Diary',
                ),
                // GButton(
                //   backgroundColor: EDpinkAcc,
                //   icon: LineIcons.heart_o,
                //   text: 'Favorite',
                // ),
                GButton(
                  backgroundColor: EDdarkPurple,
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
