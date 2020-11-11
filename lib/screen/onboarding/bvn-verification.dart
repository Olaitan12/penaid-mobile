import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/pop-up.dart';
import 'package:penaid/app-widgets/pregress-indicator.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/notifiers/confirm-otp.dart';
import 'package:penaid/screen/login-signup.dart';
import 'package:provider/provider.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/screen/onboarding/confirm-otp.dart';
import 'package:penaid/models/api-data-models/bvn-response-model.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/services/api.dart';

class OnboardingStepOneScreen extends StatefulWidget {
  // final;
  _OnboardingStepOneScreen createState() => _OnboardingStepOneScreen();
  OnboardingStepOneScreen({Key key}) : super(key: key);
}

class _OnboardingStepOneScreen extends State<OnboardingStepOneScreen> {
  var progressNotifier;

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          OnboardProgress("progress-step-one.png"),
          Container(
            padding: SCREEN_SPACE,
            height: MediaQuery.of(context).size.height,
            child: BVNForm(),
          ),
        ],
      ),
    );
  }
}

class BVNForm extends StatefulWidget {
  BVNForm({Key key}) : super(key: key);
  _BVNForm createState() => _BVNForm();
}

class _BVNForm extends State<BVNForm> {
  NotificationModel _notify = NotificationModel(null, null);
  TextEditingController _bvn = TextEditingController();
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: ImageIcon(
            AssetImage("assets/icons/bvn.png"),
            size: 120,
            color: Theme.of(context).primaryColor,
          ),
          // margin: EdgeInsets.only(top: 100),
          // child: Icon(
          // Icons.person,
          // size: 100,
          // color: Theme.of(context).primaryColor,
        ),
        Text(
          "Bank Verification Number",
          style: Theme.of(context).textTheme.headline3,
        ),
        TextFormField(
          controller: _bvn,
          decoration: InputDecoration(
            hintText: "Enter your BVN",
          ),
          textAlign: TextAlign.center,
        ),
        // Builder(builder: (context) {
        Center(child: ColorText(_notify)),
        AppButton(
          text: "Verify",
          marginTop: 0,
          onPressed: () async {
            await _verify(context);
          },
        )
        // })
      ],
    );
  }

  Future<void> _verify(BuildContext context) async {
    if (_validateBvn(_bvn.text)) {
      var response = await _verifyBvn(_bvn.text ?? "");
      if (response is APIResponseModel) {
        debugPrint(response.message);
        if (response.status) {
          BVNPayload bvnPayload = response.data["dob"] != null
              ? BVNPayload.fromPaystackJson(response.data)
              : BVNPayload.fromJson(response.data);
          if (bvnPayload.isRegisteredAppUser == null ||
              bvnPayload.isRegisteredAppUser == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<OTPNotifier>(
                  create: (context) => OTPNotifier(),
                  child: OTPForm(bvnPayload: bvnPayload),
                ),
              ),
            );
          } else {
            _displayDialog(context);
          }
        } else {
          // print(response.message.trim().length);
          _updateError(NotificationModel(response.message, null));
        }
      } else if (response is APIError) {
        _updateError(NotificationModel(response.message, null));
      }
      // _updateError("");
    } else {
      _updateError(NotificationModel("Invalid BVN", null));
    }
  }

  void _displayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopUpScreen(
        icon: Icon(
          Icons.warning,
          color: Colors.orange,
          size: 80,
        ),
        screenMessage: "BVN registered login instead. \nOR\n" +
            "If you forgot your password try password reset.",
        actionButton: AppButton(
          text: "Proceed to login",
          color: Colors.orange,
          width: MediaQuery.of(context).size.width / 2,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginSignup()));
          },
        ),
      ),
    );
  }

  void _updateError(NotificationModel notice) {
    setState(() {
      _notify = notice;
    });
  }

  Future<APIResponseModel> _verifyBvn(String bvn) async {
    API _api = GetIt.I<API>();
    throwIf(bvn.isEmpty, APIError("Invalid BVN"));
    return _api.postRequest("verify/bvn", {"bvn": bvn});
  }

  bool _validateBvn(String bvn) {
    return bvn != null && bvn.trim().length == 11;
  }
}
