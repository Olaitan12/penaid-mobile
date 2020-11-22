import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/circle-container.dart';
import 'package:penaid/forms/login.dart';

class LoginSignup extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              // colorFilter: ColorFilter.matrix([matrix]),
              fit: BoxFit.cover,
              image: AssetImage("assets/backgrounds/login.jpg")),
        ),
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          color: Color.fromRGBO(0, 0, 0, 0.2),
          child: SizedBox(
            width: 320,
            child: Stack(
              children: <Widget>[
                RoundContainer(
                  size: 120,
                  radius: 25,
                  margin: EdgeInsets.only(left: 95),
                  padding: EdgeInsets.all(10),
                  color: Color.fromRGBO(255, 255, 255, .9),
                  child: Image.asset(
                    "assets/icon.png",
                    width: 120,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class LoginSignup extends StatefulWidget {
//   _LoginSignup createState() => _LoginSignup();
// }
