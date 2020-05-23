import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';

class SignupChoiceSheet extends StatelessWidget {
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
            onPressed: () {},
          ),
          AppButton(
            text: "Agent",
            onPressed: () {},
          ),
        ]));
  }
}
