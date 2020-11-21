import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/services/data.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart' show rootBundle;

class BioDataScreen extends StatefulWidget {
  BioDataScreen(this.data);
  final AppUserData data;

  _BioDataScreen createState() => _BioDataScreen();
}

class _BioDataScreen extends State<BioDataScreen> {
  String _gender;
  String _state;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController othername,
      surname,
      firstname,
      dob,
      email,
      address,
      phoneNumber,
      nationalID = TextEditingController();
  double formSectionTitleSize = 16;
  Map<String, dynamic> formData = {};
  initState() {
    super.initState();
    setState(() {
      _gender =
          widget.data.userData == null || widget.data.userData.gender == null
              ? "male"
              : widget.data.userData.gender;
    });
  }

  Widget build(BuildContext context) {
    var userData = widget.data.userData;
    var bloc = Provider.of<TextFormBloc>(context);
    return FormCard(
      // iconData: Icons.person,
      child: Form(
        key: _formKey,
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
                        initialValue: widget.data.accessData == null
                            ? ""
                            : widget.data.accessData.surname,
                        controller: surname,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock_outline),
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
                        initialValue: widget.data.accessData == null
                            ? ""
                            : widget.data.accessData.firstname,
                        smartDashesType: SmartDashesType.disabled,
                        controller: firstname,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                            labelText: "First name"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextInputField(
                stream: bloc.otherNameStream,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isRequired),
                    bloc.othernameSubject),
                controller: othername,
                icon: Icons.person_outline,
                label: "Other name",
                initialValue: userData == null ? "" : userData.othername),
            TextInputField(
                stream: bloc.dobStream,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isDate), bloc.othernameSubject),
                controller: dob,
                icon: Icons.date_range_outlined,
                label: "Date of birth",
                initialValue: userData == null
                    ? ""
                    : dateFormat.format(DateTime.parse(userData.dateOfBirth))),
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
            TextInputField(
                stream: bloc.phoneNumberStream,
                controller: phoneNumber,
                icon: Icons.phone_outlined,
                label: "Phone number",
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isPhoneNumber),
                    bloc.phoneNumberSubject),
                initialValue: userData == null ? "" : userData.phoneNumber),
            TextInputField(
                stream: bloc.emailStream,
                controller: email,
                icon: Icons.email_outlined,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isEmail), bloc.emailSubject),
                label: "Email address",
                initialValue: userData == null ? "" : userData.email),
            TextInputField(
                stream: bloc.addressStream,
                controller: address,
                icon: Icons.home_outlined,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isRequired),
                    bloc.addressSubject),
                label: "Residential address",
                initialValue: userData == null ? "" : userData.address,
                lines: [3, 10]),
            AppDropdown(
              icon: Icon(
                Icons.my_location_outlined,
                color: Colors.grey[500],
              ),
              list: states,
              value: _state,
              placeholder: "State of residence",
              onChanged: (value) => setState(() => _state = value),
            ),
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

  // Widget textFormField(
  //         TextEditingController controller, IconData icon, String label,
  //         [initialValue, List<int> lines = const []]) =>
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 5),
  //       child: TextFormField(
  //         controller: controller,
  //         initialValue: initialValue,
  //         enabled: initialValue == null,
  //         minLines: lines.isNotEmpty ? lines[0] : null,
  //         maxLines: lines.isNotEmpty ? lines[1] : null,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: label,
  //           icon: Icon(icon),
  //         ),
  //       ),
  //     );
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

  @override
  void dispose() {
    // _formKey.currentState?.dispose();
    super.dispose();
  }

  final states = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nassarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];
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
