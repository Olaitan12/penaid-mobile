import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/data.dart';

class EmploymentForm extends StatefulWidget {
  final AppUserData data;
  EmploymentForm(this.data);
  _EmploymentForm createState() => _EmploymentForm();
}

class _EmploymentForm extends State<EmploymentForm> {
  TextEditingController employerName,
      lastJobTitle,
      yearsOfService = TextEditingController();
  String sector, industry;
  Widget build(BuildContext context) {
    UserModel userData = widget.data.userData;
    return FormCard(
      child: Form(
          child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            TextInputField(
              label: "Name of employer",
              controller: employerName,
              icon: Icons.card_travel_outlined,
              initialValue:
                  userData == null || userData.employer.employerName == null
                      ? ""
                      : userData.employer.employerName,
            ),
            TextInputField(
              controller: yearsOfService,
              icon: Icons.date_range_outlined,
              label: "Years of service",
            ),
            TextInputField(
              label: "Number years of service",
              controller: lastJobTitle,
              icon: Icons.title_outlined,
              initialValue:
                  userData == null || userData.employer.lastJobTitle == null
                      ? ""
                      : userData.employer.lastJobTitle,
            ),
            AppDropdown(
              placeholder: "Sector",
              list: ["Private", "State", "Federal"],
              value: sector,
              onChanged: (value) => setState(() => sector = value),
            ),
            AppDropdown(
              placeholder: "Industry",
              list: industries,
              value: industry,
              onChanged: (value) => setState(() => industry = value),
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
