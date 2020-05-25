import 'package:flutter/material.dart';

class PersonalInfoForm extends StatefulWidget {
  final PageController pageController;
  PersonalInfoForm(this.pageController);
  _PersonalInfoForm createState() => _PersonalInfoForm();
}

class _PersonalInfoForm extends State<PersonalInfoForm> {
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Row(children: [
          Icon(Icons.person),
          Text("Personal Bio", style: Theme.of(context).textTheme.headline2)
        ]),
        TextFormField(
          controller: null,
          decoration: InputDecoration(hintText: "Enter middle name"),
        ),
        TextFormField(
          controller: null,
          decoration: InputDecoration(hintText: "Enter email address"),
        ),
        DropdownButton(
          hint: Text("Select state of resident"),
          onChanged: (x) {},
          isExpanded: true,
          items: [
            DropdownMenuItem(
              child: Text("Lagos"),
              value: "lagos",
            )
          ],
        )
      ],
    ));
  }
}
