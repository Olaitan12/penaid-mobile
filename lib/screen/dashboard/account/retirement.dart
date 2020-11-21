import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/data.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class RetirementForm extends StatefulWidget {
  final AppUserData data;
  RetirementForm(this.data);
  _RetirementForm createState() => _RetirementForm();
}

class _RetirementForm extends State<RetirementForm> {
  TextEditingController monthyPension = TextEditingController();
  String plan;
  String pensionPlan;
  String retirementProgramType;
  String pensionFundCustodian;
  Widget build(BuildContext context) {
    UserModel userData = widget.data.userData;
    var bloc = Provider.of<TextFormBloc>(context);
    return FormCard(
      child: Form(
        child: Container(
          // margin: EdgeInsets.only(top: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextInputField(
                stream: bloc.amountStream,
                controller: monthyPension,
                icon: Icons.home,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isAmount), bloc.amountSubject),
                label: "Pension amount",
                initialValue: userData == null || userData.retirement == null
                    ? ""
                    : userData.retirement.monthlyPension.toString(),
              ),
              AppDropdown(
                list: [
                  {"name": "RSA", "code": "rsa"},
                  {"name": "PTAD", "code": "ptad"}
                ],
                value: pensionPlan,
                placeholder: "Pension plan",
                textKey: "name",
                valueKey: "code",
                onChanged: (value) =>
                    setState(() => pensionPlan = value as String),
              ),
              pensionPlan == "rsa"
                  ? AppDropdown(
                      list: ["Programmed Withdrawal", "Annuity"],
                      value: retirementProgramType,
                      placeholder: "Retirement Programme Type",
                      onChanged: (value) => setState(
                          () => retirementProgramType = value as String),
                    )
                  : Container(),
              // retirementProgramType == "" ?
              OutlineButton(
                child: Text("Save"),
                onPressed: _submitForm,
                textColor: Colors.green,
                borderSide: BorderSide(color: Colors.green),
              )
            ],
          ),
        ),
      ),
      iconData: Icons.card_travel,
    );
  }

  _submitForm() {
    debugPrint(monthyPension.text);
    debugPrint(pensionPlan);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
