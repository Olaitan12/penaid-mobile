import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/constants.dart';
// import 'package:flutter/services.dart' show rootBundle;

class BioDataScreen extends StatefulWidget {
  BioDataScreen();
  _BioDataScreen createState() => _BioDataScreen();
}

class _BioDataScreen extends State<BioDataScreen> {
  String _gender;
  TextEditingController othername,
      email,
      address,
      state,
      nationalID = TextEditingController();
  initState() {
    super.initState();
    setState(() {
      _gender = "male";
    });
    _loadStateFile();
  }

  Widget build(BuildContext context) {
    return FormCard(
      iconData: Icons.person,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: othername,
            decoration: InputDecoration(labelText: "Middle name"),
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(labelText: "Email address"),
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
          ]),
          OutlineButton(
            child: Text("Submit"),
            onPressed: () {},
            textColor: Colors.orange,
            borderSide: BorderSide(color: Colors.orange),
          )
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
