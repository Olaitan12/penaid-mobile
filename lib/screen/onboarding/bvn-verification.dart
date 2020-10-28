import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/pregress-indicator.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/notifiers/confirm-otp.dart';
import 'package:provider/provider.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/error-text.dart';
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
            padding: EdgeInsets.symmetric(horizontal: SCREEN_PADDING),
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
  String errorMessage = "";
  TextEditingController _bvn = TextEditingController();
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            // margin: EdgeInsets.only(top: 100),
            child: Icon(
          Icons.person,
          size: 100,
          color: Theme.of(context).primaryColor,
        )),
        Text(
          "Bank Verification Number",
          style: Theme.of(context).textTheme.headline3,
        ),
        TextFormField(
          controller: _bvn,
          decoration: InputDecoration(hintText: "Enter your BVN"),
        ),
        // Builder(builder: (context) {
        Center(child: ErrorText(errorMessage)),
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
          BVNPayload bvnPayload = BVNPayload.fromJson(response.data);
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
          // print(response.message.trim().length);
          _updateError(response.message);
        }
      } else if (response is APIError) {
        _updateError(response.message);
      }
      // _updateError("");
    } else {
      _updateError("Invalid BVN");
    }
  }

  void _updateError(String message) {
    setState(() {
      errorMessage = message;
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
