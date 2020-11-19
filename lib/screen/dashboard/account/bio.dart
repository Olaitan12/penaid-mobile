import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/services/data.dart';
// import 'package:flutter/services.dart' show rootBundle;

class BioDataScreen extends StatefulWidget {
  BioDataScreen();
  _BioDataScreen createState() => _BioDataScreen();
}

class _BioDataScreen extends State<BioDataScreen> {
  String _gender;
  AppUserData _data = GetIt.I<AppUserData>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController othername,
      surname,
      firstname,
      dob,
      email,
      address,
      state,
      phoneNumber,
      nationalID = TextEditingController();
  double formSectionTitleSize = 16;
  Map<String, dynamic> formData = {};
  initState() {
    super.initState();
    setState(() {
      _gender = _data.userData.gender.isEmpty ? "male" : "female";
      // firstname.text = _data.accessData.firstname;
      // surname.text = _data.accessData.surname;
    });
    _loadStateFile();
  }

  Widget build(BuildContext context) {
    return FormCard(
      // iconData: Icons.person,
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            Text("Personal data", style: FORM_TITLE),
            Divider(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 1),
                      child: TextFormField(
                        enabled: false,
                        initialValue: _data.accessData.surname,
                        controller: surname,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          labelText: "Surname",
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: TextFormField(
                        enabled: false,
                        initialValue: _data.accessData.firstname,
                        smartDashesType: SmartDashesType.disabled,
                        controller: firstname,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            labelText: "First name"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            textFormField(othername, Icons.person, "Other name"),
            textFormField(dob, Icons.date_range, "Date of birth",
                dateFormat.format(DateTime.parse(_data.userData.dateOfBirth))),
            Row(children: [
              Row(
                children: <Widget>[
                  // Icon(Icons.)
                  Padding(
                      padding: EdgeInsets.only(left: 45), child: Text("Male")),
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
            Text("Contact Information", style: FORM_TITLE),
            textFormField(phoneNumber, Icons.phone, "Phone number",
                _data.userData.phoneNumber),
            textFormField(
                email, Icons.email, "Email address", _data.userData.email),
            textFormField(address, Icons.home, "Residential address",
                _data.userData.address, [3, 10]),
            OutlineButton(
              child: Text("Save"),
              onPressed: _submitForm,
              textColor: Colors.green,
              borderSide: BorderSide(color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  Widget textFormField(
          TextEditingController controller, IconData icon, String label,
          [initialValue, List<int> lines = const []]) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          enabled: initialValue == null,
          minLines: lines.isNotEmpty ? lines[0] : null,
          maxLines: lines.isNotEmpty ? lines[1] : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            icon: Icon(icon),
          ),
        ),
      );
  _setGender(String gender) {
    setState(() {
      // formData["gender"] = _gender;
      _gender = gender;
      debugPrint(_gender);
    });
  }

  _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    debugPrint(formData.values.toString());
  }

  Future<void> _loadStateFile() async {
    var state = await rootBundle.loadString("assets/states.json");
    debugPrint(state);
  }
}

class StatesDropDown extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getStates(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              debugPrint(snapshot.data.toString());
              return DropdownButton(
                hint: Text("Select state of residence"),
                onChanged: (x) {},
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    child: Text("Lagos"),
                    value: "lagos",
                  )
                ],
              );
              break;
            default:
              return CircularProgressIndicator();
          }
        });
  }
}
