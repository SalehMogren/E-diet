import 'package:e_diet/Model/Auth.dart';
import 'package:e_diet/Model/routing_constants.dart';
import 'package:e_diet/Pages/Widgets/Background.dart';
import 'package:e_diet/Pages/home/Profile/ChangePass.dart';
import 'package:e_diet/Pages/home/Profile/EditProfile.dart';
import 'package:e_diet/Pages/home/Profile/EditDiet.dart';
import 'package:flutter/material.dart';
import '../../../Model/UI/Colors.dart';
import '../../Widgets/Buttons.dart';
import 'package:provider/provider.dart';
import 'package:e_diet/Model/UserM.dart';

class ProfilePageNew extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserModle testingUser = new UserModle(uid: 'testing');
    testingUser.name = 'Test User';
    testingUser.photoUrl = 'null';
    final user = Provider.of<UserModle>(context);
    return FutureBuilder<UserModle>(
        future: user.fetchData(),
        initialData: testingUser,
        builder: (context, AsyncSnapshot<UserModle> snapshot) {
          if (snapshot == null || snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Background(
            color1: Colors.transparent,
            color2: Colors.transparent,
            color3: Colors.transparent,
            color4: Colors.transparent,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: EDdarkPurple.withOpacity(0.95),
                      child: Container(
                        height: size.height * 0.2,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: CircleAvatar(
                                  foregroundColor: ELightBlue0,
                                  radius: 40,
                                  backgroundImage: snapshot.data.photoUrl ==
                                          'null'
                                      ? AssetImage('assets/profile.png')
                                      : NetworkImage(snapshot.data.photoUrl),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.name,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: EDwhite,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.end,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.end,
                                      //     children: <Widget>[
                                      //       Padding(
                                      //         padding: EdgeInsets.fromLTRB(
                                      //             100, 10, 0, 0),
                                      //         child: IconButton(
                                      //             icon: Icon(
                                      //               Icons.edit,
                                      //               color: EDwhite,
                                      //             ),
                                      //             onPressed: () {}),
                                      //       ),
                                      //     ])
                                    ]),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    settingsOption(context),
                    // SizedBox(
                    //   height: size.height * 0.04,
                    // ),
                    RoundedButton(
                      color: EDpinkAcc,
                      text: 'Log out',
                      width: size.width * 0.8,
                      press: () async {
                        await _auth.signOut();

                        Navigator.popAndPushNamed(context, WelcomeViewRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget settingsOption(BuildContext context) {
    return Card(
        elevation: 4.0,
        margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.lock_outline,
                color: Colors.purple[600],
                size: 24,
              ),
              title: Text(
                "Change Password",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePass())),
            ),
            _buildDivider(),
            ListTile(
              leading: Icon(
                Icons.person_outline_outlined,
                color: Colors.purple[600],
                size: 24,
              ),
              title: Text(
                "Edit Profile Info",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                //open change password
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ));
              },
            ),
            _buildDivider(),
            ListTile(
              leading: Icon(
                Icons.fastfood_outlined,
                color: Colors.purple[600],
                size: 24,
              ),
              title: Text(
                "Change Diet",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              //   onTap: () => Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => EditDiet())),
            ),
            _buildDivider(),
            ListTile(
              leading: Icon(
                Icons.flag,
                color: Colors.purple[600],
                size: 24,
              ),
              title: Text(
                "Change Goal",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditGoal())),
            ),
          ],
        ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10,
      ),
      width: double.infinity,
      height: 1.0,
    );
  }
}
