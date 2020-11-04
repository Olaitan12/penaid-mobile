import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/notifiers/confirm-otp.dart';
import 'package:penaid/screen/onboarding/confirm-otp.dart';
import 'package:penaid/models/api-data-models/password-reset.dart';
import 'package:penaid/services/api.dart';
import 'package:provider/provider.dart';

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  TextEditingController _bvn = TextEditingController();
  NotificationModel _noticeModel = NotificationModel(null, null);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Icon(
                Icons.phonelink_lock,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Reset Password",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: _bvn,
                decoration: InputDecoration(hintText: "Enter your BVN"),
              ),
              ColorText(_noticeModel),
              AppButton(
                text: "Submit",
                onPressed: () {
                  _verify(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verify(BuildContext context) async {
    if (_validateBvn(_bvn.text)) {
      var response = await _verifyPhoneNumber();
      if (response is APIResponseModel) {
        // debugPrint(response.message);
        debugPrint(response.data.toString());
        debugPrint("response.data.toString()");
        if (response.status) {
          _notifyUser(NotificationModel(response.message, Colors.green));
          var payload = ResetPasswordPayload.fromJson(response.data);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<OTPNotifier>(
                create: (context) => OTPNotifier(),
                child: OTPForm(
                  resetPasswordPayload: payload,
                ),
              ),
            ),
          );
        } else {
          _notifyUser(NotificationModel(response.message, null));
        }
      } else {
        // print(response.message.trim().length);
        _notifyUser(NotificationModel(response.message, null));
      }
    }
  }

  void _notifyUser(NotificationModel model) {
    setState(() {
      _noticeModel = model;
    });
  }

  Future<APIResponseModel> _verifyPhoneNumber() async {
    API _api = GetIt.I<API>();
    throwIf(_bvn.text == null || _bvn.text == null || _bvn.text.length < 11,
        APIError("Invalid phone number"));
    return _api.postRequest("user/resetPassword", {"bvn": _bvn.text});
  }

  bool _validateBvn(String bvn) {
    return bvn != null && bvn.trim().length == 11;
  }
}

class ResetPasswordScreen extends StatefulWidget {
  _ResetPasswordScreen createState() => _ResetPasswordScreen();
}
