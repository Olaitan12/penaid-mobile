import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/notifiers/onboarding-progress.dart';
import 'package:penaid/screen/onboarding/step-one.dart';
import 'package:provider/provider.dart';

class SignupChoiceSheet extends StatefulWidget {
  _SignupChoiceSheet createState() => _SignupChoiceSheet();
}

class _SignupChoiceSheet extends State<SignupChoiceSheet> {
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, .8),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "I want to sign up as a ",
            style: Theme.of(context).textTheme.headline2,
          ),
          AppButton(
            text: "Pension",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChangeNotifierProvider<OnboardingProgressNotifier>(
                    create: (context) => OnboardingProgressNotifier(),
                    builder: (context, child) => OnboardingStepOneScreen(),
                  ),
                ),
              );
            },
          ),
          AppButton(
            text: "Agent",
            onPressed: () {},
          ),
        ]));
  }
}
