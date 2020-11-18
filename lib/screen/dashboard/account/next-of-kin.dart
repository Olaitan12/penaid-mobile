import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/form-card.dart';

class NextOfKinForm extends StatefulWidget {
  _NextOfKinForm createState() => _NextOfKinForm();
}

class _NextOfKinForm extends State<NextOfKinForm> {
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
          child: Container(
        child: Text("Hello"),
      )),
      iconData: Icons.people_outline,
    );
  }
}
