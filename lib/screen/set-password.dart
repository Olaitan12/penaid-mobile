import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/models/api-data-models/bvn-response-model.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/screen/login-signup.dart';
import 'package:penaid/app-widgets/pop-up.dart';
import 'package:penaid/models/api-data-models/password-reset.dart';
import 'package:penaid/services/api.dart';

/**
 * This screen represents two flows
 * Reset password ==> ResetpasswordPayload is not null
 * and
 * Onboarding ==> BVNPayload is not null
 */
class SetPasswordScreen extends StatefulWidget {
  final BVNPayload bvnPayload;
  final ResetPasswordPayload resetPasswordPayload;
  _SetPasswordScreen createState() => _SetPasswordScreen();
  SetPasswordScreen({this.bvnPayload, this.resetPasswordPayload});
}

class _SetPasswordScreen extends State<SetPasswordScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  NotificationModel _notificeModel = NotificationModel("", null);
  String _submitButtonText;
  String _url;
  API _api = GetIt.I<API>();
  // BVNPayload _bvnPayload = widget.bvnPayload;
  initState() {
    debugPrint(widget.bvnPayload.toString());
    super.initState();
    if (widget.bvnPayload != null) {
      _submitButtonText = "Set password";
      _url = "user/register/appUser";
    } else if (widget.resetPasswordPayload != null) {
      _submitButtonText = "Update password";
      _url = "user/resetPassword";
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        alignment: Alignment.center,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: ImageIcon(
                  AssetImage("assets/icons/password.png"),
                  color: Theme.of(context).primaryColor,
                  size: 100,
                ),
              ),
              Center(
                child: Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                onChanged: (x) {
                  if (_confirmPassword.text is String) _passwordCombination();
                },
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              TextFormField(
                controller: _confirmPassword,
                obscureText: true,
                onChanged: (x) {
                  _passwordCombination();
                },
                decoration: InputDecoration(hintText: "Confirm password"),
              ),
              // Builder(builder: (context) {
              ColorText(_notificeModel),
              AppButton(
                text: _submitButtonText,
                marginTop: 0,
                onPressed: () async {
                  if (widget.bvnPayload != null) {
                    await _sendSetPasswordRequest();
                  } else if (widget.resetPasswordPayload != null) {
                    await _resetPassword();
                  } else {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _passwordCombination() {
    if (_password.text != null && _password.text.length < 4) {
      _nofityUser(NotificationModel("Password length too short", null));
    } else if (_confirmPassword.text == null ||
        _password.text == null ||
        _password.text != _confirmPassword.text) {
      _nofityUser(NotificationModel("Password combination incorrect", null));
    } else if (_confirmPassword.text == _password.text &&
        _password.text != "" &&
        _password.text != null) {
      _nofityUser(NotificationModel("", null));
    }
  }

  void _nofityUser(NotificationModel model) {
    setState(() {
      _notificeModel = model;
    });
  }

  Future<void> _resetPassword() async {
    debugPrint("Reset request sent");
    Map<String, String> payload = {
      "userId": widget.resetPasswordPayload.userId,
      "password": _password.text
    };
    var response = await _api.putRequest(_url, payload);
    if (response.status) {
      debugPrint(response.data.toString());
      _dispayDialog(context);
    } else {
      _nofityUser(NotificationModel(response.message, null));
    }
  }

  Future<void> _sendSetPasswordRequest() async {
    Map<String, dynamic> payload = bvnPayloadObjectToMap(widget.bvnPayload);
    payload["password"] = _password.text;
    debugPrint(payload.toString());
    var response = await _api.postRequest(_url, payload);
    if (response.status) {
      debugPrint(response.data.toString());
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginSignup()));
      _dispayDialog(context);
    } else {
      _nofityUser(NotificationModel(response.message, null));
    }
  }

  _dispayDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => PopUpScreen(
        screenMessage: "Password update successful.\nYou can procced to login.",
        icon: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 100,
        ),
        actionButton: AppButton(
          text: "Proceed to login",
          color: Colors.green,
          width: MediaQuery.of(context).size.width / 2,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginSignup()));
          },
        ),
      ),
    );
  }

  Map<String, dynamic> bvnPayloadObjectToMap(BVNPayload payload) {
    return {
      "bvn": payload.bvn,
      "surname": payload.surname,
      "firstname": payload.firstname,
      "date_of_birth": payload.dateOfBirth,
      "phone": payload.phoneNumber,
    };
  }
}
