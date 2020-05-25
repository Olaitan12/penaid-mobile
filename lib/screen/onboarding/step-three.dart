import 'package:flutter/material.dart';
import 'package:penaid/forms/personal-information.dart';

class OnboardingStepThree extends StatelessWidget {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: .9);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView(
          children: <Widget>[
            Image.asset("assets/images/progress-step-three.png"),
            Container(
              child: Column(
                children: <Widget>[
                  PageView(
                    controller: _pageController,
                    children: <Widget>[PersonalInfoForm(_pageController)],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
