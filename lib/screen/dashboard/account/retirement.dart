import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/app-widgets/upload-file.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class RetirementForm extends StatefulWidget {
  // final AppUserData data;
  RetirementForm();
  _RetirementForm createState() => _RetirementForm();
}

class _RetirementForm extends State<RetirementForm> {
  TextEditingController monthyPension = TextEditingController();
  String plan;
  String pensionPlan;
  String retirementProgramType;
  String pensionFundCustodian;
  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;
    pensionPlan = userData == null ||
            userData.retirement == null ||
            userData.retirement.pensionPlan == null
        ? null
        : userData.retirement.pensionPlan;
    retirementProgramType = userData == null ||
            userData.retirement == null ||
            userData.retirement.pensionPlan == null
        ? null
        : userData.retirement.pensionPlan;
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
                icon: ImageIcon(AssetImage("assets/icons/naira.png")),
                // icon: Icons.home,
                onChanged: (value) => bloc.process(
                    Validate(value, Validation.isAmount), bloc.amountSubject),
                label: "Pension amount",
                initialValue: userData == null || userData.retirement == null
                    ? ""
                    : userData.retirement.monthlyPension.toString(),
              ),
              AppDropdown(
                list: ["RSA", "PTAD"],
                value: pensionPlan,
                placeholder: "Pension plan",
                // textKey: "name",
                // valueKey: "code",
                onChanged: (value) => setState(() => pensionPlan = value),
              ),
              pensionPlan == "RSA"
                  ? AppDropdown(
                      list: ["Programmed Withdrawal", "Annuity"],
                      value: retirementProgramType,
                      placeholder: "Retirement Programme Type",
                      onChanged: (value) => setState(
                          () => retirementProgramType = value as String),
                    )
                  : Container(),
              // retirementProgramType == "" ?
              DocumentUpload(
                type: "Retirement Document",
                documentType: UploadDocumentType.retirementDocument,
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
    // bloc.dispose();
    super.dispose();
  }
}
