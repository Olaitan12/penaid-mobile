import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/app-widgets/upload-file.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class BioDataScreen extends StatefulWidget {
  BioDataScreen();
  _BioDataScreen createState() => _BioDataScreen();
}

class _BioDataScreen extends State<BioDataScreen> {
  String _gender;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController othername,
      surname,
      firstname,
      dob = TextEditingController();
  double formSectionTitleSize = 16;
  Map<String, dynamic> formData = {};
  initState() {
    super.initState();
  }

  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;

    _gender =
        userData == null || userData.gender == null ? "male" : userData.gender;
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
                        initialValue: userData == null ? "" : userData.surname,
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
                        initialValue:
                            userData == null ? "" : userData.firstname,
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
                icon: Icon(Icons.person_outlined),
                label: "Other name",
                initialValue: userData == null ? "" : userData.othername),
            TextInputField(
                stream: bloc.dobStream,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isDate), bloc.othernameSubject),
                controller: dob,
                icon: Icon(Icons.date_range_outlined),
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
                      value: "male", groupValue: _gender, onChanged: _setGender)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Female"),
                  Radio(
                      value: "female",
                      groupValue: _gender,
                      onChanged: _setGender)
                ],
              ),
            ]),
            DocumentUpload(
              type: "Upload ID card",
              documentType: UploadDocumentType.utilityBill,
              //  uploadFileDescription: null,
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

  _setGender(String gender) {
    debugPrint(gender);
    setState(() {
      _gender = gender;
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
    super.dispose();
  }
}
