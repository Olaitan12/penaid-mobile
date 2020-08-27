import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

class PersonalInfoForm extends StatefulWidget {
  final PageController pageController;
  PersonalInfoForm(this.pageController);
  _PersonalInfoForm createState() => _PersonalInfoForm();
}

class _PersonalInfoForm extends State<PersonalInfoForm> {
  String _gender;
  initState() {
    super.initState();
    setState(() {
      _gender = "male";
    });
    _loadStateFile();
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          // Row(children: [
          Icon(
            Icons.person,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          Center(
            child: Text("Personal Bio",
                style: Theme.of(context).textTheme.headline2),
          ),
          // ]),
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
          ),
          Row(children: [
            Row(
              children: <Widget>[
                Text("Male"),
                Radio(
                    value: "male",
                    groupValue: _gender,
                    onChanged: (gender) {
                      _setGender(gender);
                    })
              ],
            ),
            Row(
              children: <Widget>[
                Text("Female"),
                Radio(
                    value: "female",
                    groupValue: _gender,
                    onChanged: (gender) {
                      _setGender(gender);
                    })
              ],
            ),
          ])
        ],
      ),
    );
  }

  _setGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  Future<void> _loadStateFile() async {
    // var state = rootBundle.loadString("../../assets");
    // print(state);
  }
}
