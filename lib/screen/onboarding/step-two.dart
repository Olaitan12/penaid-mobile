import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/pregress-indicator.dart';
import 'package:penaid/forms/personal-information.dart';

class OnboardingStepTwo extends StatelessWidget {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: .9, keepPage: true);
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          OnboardProgress("progress-step-two.png"),
          Container(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: <Widget>[PersonalInfoForm(_pageController)],
            ),
          ),
        ],
      ),
    );
  }
}
