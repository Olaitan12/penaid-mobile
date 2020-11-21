import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/services/data.dart';

class NextOfKinForm extends StatefulWidget {
  final AppUserData data;
  NextOfKinForm(this.data);
  _NextOfKinForm createState() => _NextOfKinForm();
}

class _NextOfKinForm extends State<NextOfKinForm> {
  TextEditingController firstname,
      surname,
      othername,
      relationship,
      phoneNumber,
      address = TextEditingController();
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
          child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            TextInputField(
              label: "Surname",
              controller: surname,
              icon: Icons.person_outline_outlined,
            ),
            TextInputField(
              label: "First name",
              controller: firstname,
              icon: Icons.person_outline_outlined,
            ),
            TextInputField(
              label: "Other name",
              controller: othername,
              icon: Icons.person_outline_outlined,
            ),
            TextInputField(
              label: "Relationship",
              controller: relationship,
              icon: Icons.people_outline_outlined,
            ),
            TextInputField(
              label: "Phone number",
              controller: phoneNumber,
              icon: Icons.phone_outlined,
            ),
            TextInputField(
              label: "House address",
              controller: address,
              icon: Icons.home_outlined,
            ),
            OutlineButton(
              child: Text("Save"),
              onPressed: _submitForm,
              textColor: Colors.green,
              borderSide: BorderSide(color: Colors.green),
            )
          ],
        ),
      )),
      iconData: Icons.people_outline,
    );
  }

  _submitForm() {}
}
