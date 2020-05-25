import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/pregress-indicator.dart';
import 'package:penaid/forms/bvn.dart';
import 'package:penaid/forms/confirm-otp.dart';
import 'package:penaid/notifiers/onboarding-progress.dart';
import 'package:provider/provider.dart';

class OnboardingStepOneScreen extends StatefulWidget {
  // final;
  _OnboardingStepOneScreen createState() => _OnboardingStepOneScreen();
  // OnboardingStepOneScreen({Key key}) : super(key: key);
}

class _OnboardingStepOneScreen extends State<OnboardingStepOneScreen> {
  var progressNotifier;
  PageController pageController =
      PageController(viewportFraction: 1, initialPage: 0);
  Widget build(BuildContext context) {
    progressNotifier = Provider.of<OnboardingProgressNotifier>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          OnboardProgress("progress-step-one.png"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height,
            child: PageView(
              pageSnapping: true,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: progressNotifier.progress,
              children: [BVNForm(pageController: pageController), OTPForm()],
            ),
          ),
        ],
      ),
    );
  }
}
