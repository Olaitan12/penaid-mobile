import 'package:flutter/material.dart';

import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/app-widgets/upload-file.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/api.dart';
// import 'package:penaid/services/data.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart' show rootBundle;

class ContactInfoScreen extends StatefulWidget {
  ContactInfoScreen();
  // final AppUserData data;
  _ContactInfoScreen createState() => _ContactInfoScreen();
}

class _ContactInfoScreen extends State<ContactInfoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email,
      address,
      phoneNumber,
      nationalID = TextEditingController();
  double formSectionTitleSize = 16;
  Map<String, dynamic> formData = {};
  String _state;
  initState() {
    super.initState();
  }

  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;
    _state = userData == null || userData.stateOfResisdence == null
        ? "male"
        : userData.stateOfResisdence;
    return FormCard(
      // iconData: Icons.person,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            Text("Contact Information", style: FORM_TITLE),
            TextInputField(
                stream: bloc.phoneNumberStream,
                controller: phoneNumber,
                icon: Icon(Icons.phone_outlined),
                label: "Phone number",
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isPhoneNumber),
                    bloc.phoneNumberSubject),
                initialValue: userData == null ? "" : userData.phoneNumber),
            TextInputField(
                stream: bloc.emailStream,
                controller: email,
                icon: Icon(Icons.email_outlined),
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isEmail), bloc.emailSubject),
                label: "Email address",
                initialValue: userData == null ? "" : userData.email),
            TextInputField(
                stream: bloc.addressStream,
                controller: address,
                icon: Icon(Icons.home_outlined),
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
              list: _states,
              value: _state,
              placeholder: "State of residence",
              onChanged: (value) => setState(() => _state = value),
            ),
            DocumentUpload(
              type: "Upload utility bill",
              documentType: UploadDocumentType.utilityBill,
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

  _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    debugPrint(formData.values.toString());
  }

  @override
  void dispose() {
    // _formKey.currentState?.dispose();
    // bloc.dispose();
    super.dispose();
  }

  final _states = [
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
