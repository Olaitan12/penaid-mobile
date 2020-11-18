import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/form-card.dart';

class RetirementForm extends StatefulWidget {
  _RetirementForm createState() => _RetirementForm();
}

class _RetirementForm extends State<RetirementForm> {
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
          child: Container(
        child: Text("Hello"),
      )),
      iconData: Icons.card_travel,
    );
  }
}
