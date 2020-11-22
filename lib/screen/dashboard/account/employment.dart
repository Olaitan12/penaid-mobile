import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/app-widgets/upload-file.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class EmploymentForm extends StatefulWidget {
  // final AppUserData data;
  EmploymentForm();
  _EmploymentForm createState() => _EmploymentForm();
}

class _EmploymentForm extends State<EmploymentForm> {
  TextEditingController employerName,
      lastJobTitle,
      yearsOfService = TextEditingController();
  String sector, industry;
  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;
    sector = userData == null ||
            userData.employer == null ||
            userData.employer.sector == null
        ? ""
        : userData.employer.sector.toLowerCase();
    return FormCard(
      child: Form(
          child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            TextInputField(
              label: "Name of employer",
              controller: employerName,
              icon: Icon(Icons.card_travel_outlined),
              initialValue:
                  userData == null || userData.employer.employerName == null
                      ? ""
                      : userData.employer.employerName,
            ),
            TextInputField(
              controller: yearsOfService,
              icon: Icon(Icons.date_range_outlined),
              label: "Years of service",
              initialValue:
                  userData == null || userData.employer.yearsOfService == null
                      ? ""
                      : userData.employer.yearsOfService.toString(),
            ),
            TextInputField(
              label: "Number years of service",
              controller: lastJobTitle,
              icon: Icon(Icons.title_outlined),
              initialValue:
                  userData == null || userData.employer.lastJobTitle == null
                      ? ""
                      : userData.employer.lastJobTitle,
            ),
            AppDropdown(
              placeholder: "Sector",
              list: [
                {"name": "Private", "code": "private"},
                {"name": "State", "code": "state"},
                {"name": "Federal", "code": "federal"}
              ],
              textKey: "name",
              valueKey: "code",
              value: sector,
              onChanged: (value) => setState(() => sector = value),
            ),
            AppDropdown(
              placeholder: "Industry",
              list: industries,
              value: industry,
              onChanged: (value) => setState(() => industry = value),
            ),
            DocumentUpload(),
            OutlineButton(
              child: Text("Save"),
              onPressed: _submitForm,
              textColor: Colors.green,
              borderSide: BorderSide(color: Colors.green),
            )
          ],
        ),
      )),
      iconData: Icons.card_travel,
    );
  }

  _submitForm() {
    // debugPrint(monthyPension.text);
    // debugPrint(pensionPlan);
  }
  List<String> industries = [
    "Federal Civil Service",
    "Lagos State Ministry of Health",
    "Nigeria Port Authority",
    "Nigeria Navy",
    "Nigeria Army",
    "Nigeria Airforce",
    "Education"
        "Lagos State Civil Service Commission",
    "Nitel",
    "Postal Services"
        "Nigerian Railway Corporation",
    "Custom Service",
    "Housing",
    "Local Goverment Commission (Ikeja)",
    "University of Lagos",
    "Intercontinental Distillery",
    "Lagos State Primary Education Board",
    "University of Lagos",
    "Eko Electricity Distribution Company",
    "Lagos Television Authority",
    "College of Medicine UNILAG",
    "Lagos State Ministry of Agriculture and Cooperatives",
    "Ministry of Agriculture and Cooperative",
    "Federal Ministry of Information",
    "Ikeja Electric",
    "Nigerian Television Authority",
    "NTA Network News VI Lagos",
  ];
}
