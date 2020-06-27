import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/bottom-sheet/signup-choice.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/forms/login.dart';

class _LoginSignup extends State<LoginSignup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                fit: BoxFit.cover,
                image: AssetImage("assets/backgrounds/login.jpg")),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon.png",
                width: 120,
              ),
              AppButton(
                  onPressed: () {
                    _scaffoldKey.currentState
                        .showBottomSheet((context) => LoginForm());
                  },
                  text: "Login",
                  width: MediaQuery.of(context).size.width),
              AppButton(
                onPressed: () {
                  _scaffoldKey.currentState
                      .showBottomSheet((context) => SignupChoiceSheet());
                },
                text: "Signup",
              )
            ],
          )),
    );
  }
}

class LoginSignup extends StatefulWidget {
  _LoginSignup createState() => _LoginSignup();
}
