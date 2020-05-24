import 'package:flutter/material.dart';
import 'package:penaid/forms/bvn.dart';
import 'package:penaid/forms/confirm-otp.dart';
import 'package:penaid/notifiers/onboarding-progress.dart';
import 'package:provider/provider.dart';

class OnboardingIndexScreen extends StatefulWidget {
  // final;
  _OnboardingIndexScreen createState() => _OnboardingIndexScreen();
  // OnboardingIndexScreen({Key key}) : super(key: key);
}

class _OnboardingIndexScreen extends State<OnboardingIndexScreen> {
  var progressNotifier;
  PageController pageController =
      PageController(viewportFraction: 1, initialPage: 0);
  Widget build(BuildContext context) {
    progressNotifier = Provider.of<OnboardingProgressNotifier>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        decoration: null,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 40, left: 15, right: 15),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              height: 450,
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
      ),
    );
  }
}
