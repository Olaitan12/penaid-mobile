import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/dropdown.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/app-widgets/text-field.dart';
import 'package:penaid/app-widgets/upload-file.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class BankDetails extends StatefulWidget {
  // final AppUserData data;
  BankDetails();
  _BankDetails createState() => _BankDetails();
}

class _BankDetails extends State<BankDetails> {
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController accountNumber = TextEditingController();
  String bankCode;
  bool verified = false;
  TextFormBloc bloc;
  Widget build(BuildContext context) {
    bloc = Provider.of<TextFormBloc>(context);
    UserModel userData = bloc.data.userData;
    bankCode = userData == null || userData.bankCode == null
        ? null
        : userData.bankCode;
    return FormCard(
      child: Column(
        children: [
          TextInputField(
            stream: bloc.accountNumberStream,
            controller: accountNumber,
            icon: Icon(Icons.account_balance_outlined),
            label: "Pension account number",
            initialValue: userData == null ? "" : userData.accountNumber,
            onChanged: (value) => bloc.process(
                Validate(value, Validation.isAccountNumber),
                bloc.accountNumberSubject),
          ),
          AppDropdown(
            placeholder: "Bank",
            listOfMap: _banks,
            value: bankCode,
            valueKey: "code",
            textKey: "name",
            onChanged: (value) => setState(() => bankCode = value),
          ),
          DocumentUpload(
            documentType: UploadDocumentType.bankStatement,
            // icon: Icon(Icons.picture_as_pdf_outlined),
            type: "Bank statement",
            uploadFileDescription: "Last three month",
          ),
        ],
      ),
      // iconData: Icons.people_outline,
    );
  }

  @override
  void dispose() {
    // bloc.dispose();
    // _formKey.currentState.dispose();
    super.dispose();
  }

  final _banks = [
    {"name": "Access Bank", "code": "044"},
    {"name": "Access Bank (Diamond)", "code": "063"},
    {"name": "ALAT by WEMA", "code": "035A"},
    {"name": "Citibank Nigeria", "code": "023"},
    {"name": "Ecobank Nigeria", "code": "050"},
    {"name": "Fidelity Bank", "code": "070"},
    {"name": "First Bank of Nigeria", "code": "011"},
    {"name": "First City Monument Bank", "code": "214"},
    {"name": "Guaranty Trust Bank", "code": "058"},
    {"name": "Heritage Bank", "code": "030"},
    {"name": "Keystone Bank", "code": "082"},
    {"name": "Kuda Bank", "code": "50211"},
    {"name": "Polaris Bank", "code": "076"},
    {"name": "Providus Bank", "code": "101"},
    {"name": "Stanbic IBTC Bank", "code": "221"},
    {"name": "Standard Chartered Bank", "code": "068"},
    {"name": "Sterling Bank", "code": "232"},
    {"name": "Union Bank of Nigeria", "code": "032"},
    {"name": "United Bank For Africa", "code": "033"},
    {"name": "Unity Bank", "code": "215"},
    {"name": "Wema Bank", "code": "035"},
    {"name": "Zenith Bank", "code": "057"}
  ];
}
