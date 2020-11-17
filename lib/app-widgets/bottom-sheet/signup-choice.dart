import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/screen/onboarding/bvn-verification.dart';

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
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Sign up as",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          AppButton(
            text: "a Pensioner",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingStepOneScreen(),
                ),
              );
            },
          ),
          AppButton(
            text: "an Agent",
            onPressed: () {},
          ),
        ]));
  }
}
