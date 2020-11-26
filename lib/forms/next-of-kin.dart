import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/models/api-data-models/user.dart';
// import 'package:penaid/services/data.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class NextOfKinForm extends StatefulWidget {
  // final AppUserData data;
  NextOfKinForm();
  _NextOfKinForm createState() => _NextOfKinForm();
}

class _NextOfKinForm extends State<NextOfKinForm> {
  TextEditingController firstname,
      surname,
      othername,
      relationship,
      phoneNumber,
      address = TextEditingController();
  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;
    return FormCard(
      child: Form(
          child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            TextInputField(
              label: "Surname",
              stream: bloc.nokSurnameStream,
              controller: surname,
              icon: Icon(Icons.person_outline_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isRequired),
                    bloc.nokSurnameSubject);
              },
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.surname == null
                  ? ""
                  : userData.nextOfKin.surname,
            ),
            TextInputField(
              label: "First name",
              stream: bloc.nokFirstnameStream,
              controller: firstname,
              icon: Icon(Icons.person_outline_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isRequired),
                    bloc.nokFirstnameSubject);
              },
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.firstName == null
                  ? ""
                  : userData.nextOfKin.firstName,
            ),
            TextInputField(
              label: "Other name",
              stream: bloc.nokOthernameStream,
              controller: othername,
              icon: Icon(Icons.person_outline_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isNotRequired),
                    bloc.nokSurnameSubject);
              },
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.othername == null
                  ? ""
                  : userData.nextOfKin.othername,
            ),
            TextInputField(
              label: "Relationship",
              stream: bloc.nokRelationshipStream,
              controller: relationship,
              icon: Icon(Icons.people_outline_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isRequired),
                    bloc.nokRelationshipSubject);
              },
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.relationship == null
                  ? ""
                  : userData.nextOfKin.relationship,
            ),
            TextInputField(
              label: "Phone number",
              stream: bloc.nokPhoneNumberStream,
              controller: phoneNumber,
              icon: Icon(Icons.phone_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isRequired),
                    bloc.nokPhoneNumberSubject);
              },
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.phoneNumber == null
                  ? ""
                  : userData.nextOfKin.phoneNumber,
            ),
            TextInputField(
              label: "House address",
              stream: bloc.nokAddressStream,
              controller: address,
              icon: Icon(Icons.home_outlined),
              onChanged: (value) {
                bloc.process(Validate(value, Validation.isRequired),
                    bloc.nokAddressSubject);
              },
              lines: [3, 10],
              initialValue: userData == null ||
                      userData.nextOfKin == null ||
                      userData.nextOfKin.address == null
                  ? ""
                  : userData.nextOfKin.address,
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

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }
}
