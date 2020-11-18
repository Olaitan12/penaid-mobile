import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/form-card.dart';

class EmploymentForm extends StatefulWidget {
  _EmploymentForm createState() => _EmploymentForm();
}

class _EmploymentForm extends State<EmploymentForm> {
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
