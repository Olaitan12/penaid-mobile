import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/form-card.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/services/data.dart';

class BankDetails extends StatefulWidget {
  _BankDetails createState() => _BankDetails();
}

class _BankDetails extends State<BankDetails> {
  AppUserData _data = GetIt.I<AppUserData>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountNumber = TextEditingController();
  Widget build(BuildContext context) {
    debugPrint(_data.userData.accountNumber);
    return FormCard(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            textFormField(accountNumber, Icons.account_balance,
                "Account number", _data.userData.accountNumber),
          ],
        ),
      ),
      iconData: Icons.people_outline,
    );
  }
}
