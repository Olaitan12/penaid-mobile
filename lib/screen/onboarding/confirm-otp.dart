import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/bvn-response-model.dart';
import 'package:penaid/notifiers/confirm-otp.dart';
import 'package:penaid/screen/set-password.dart';

import 'package:provider/provider.dart';

class OTPForm extends StatefulWidget {
  final BVNPayload bvnPayload;
  _OTPForm createState() => _OTPForm();
  OTPForm({this.bvnPayload, Key key}) : super(key: key);
}

class _OTPForm extends State<OTPForm> {
  final nodeOne = FocusNode();
  final nodeTwo = FocusNode();
  final nodeThree = FocusNode();
  final nodeFour = FocusNode();
  final nodeFive = FocusNode();
  final nodeSix = FocusNode();

  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();
  TextEditingController six = TextEditingController();
  var notifyListner;
  initState() {
    debugPrint(widget.bvnPayload.toString());
    super.initState();
  }

  void initListner(BuildContext context) {
    var notifier = Provider.of<OTPNotifier>(context);
    if (widget.bvnPayload == null) {
      notifier.setErrorMessage("No SMS token found");
    } else if (widget.bvnPayload is BVNPayload) {
      notifier.setBVNPayload(widget.bvnPayload);
      // notifier.
    } else {}
  }

  Widget build(BuildContext context) {
    // widget.
    initListner(context);
    return MaterialApp(
      theme: Theme.of(context),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: SCREEN_PADDING),
          child: Center(
              child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.check,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Center(
                child: Text(
                  "Confirm OTP",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                // width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OTPBox(
                      controller: one,
                      currentFocusNode: nodeOne,
                      previosFocusNode: null,
                      nextFocusNode: nodeTwo,
                    ),
                    OTPBox(
                      controller: two,
                      currentFocusNode: nodeTwo,
                      previosFocusNode: nodeOne,
                      nextFocusNode: nodeThree,
                    ),
                    OTPBox(
                      controller: three,
                      currentFocusNode: nodeThree,
                      previosFocusNode: nodeTwo,
                      nextFocusNode: nodeFour,
                    ),
                    OTPBox(
                      controller: four,
                      currentFocusNode: nodeFour,
                      previosFocusNode: nodeThree,
                      nextFocusNode: nodeFive,
                    ),
                    OTPBox(
                      controller: five,
                      currentFocusNode: nodeFive,
                      previosFocusNode: nodeFour,
                      nextFocusNode: nodeSix,
                    ),
                    OTPBox(
                      controller: six,
                      currentFocusNode: nodeSix,
                      previosFocusNode: nodeFive,
                      nextFocusNode: null,
                    ),
                  ],
                ),
              ),
              // Center(
              //   heightFactor: 5,
              //   child: Text("Didn't get OTP? Resend"),
              // ),
              Container(
                child:
                    Consumer<OTPNotifier>(builder: (context, notifier, child) {
                  if (notifier.apiResponseModel == null)
                    notifier.sendOtpViaText();
                  return Column(
                    children: [
                      Container(
                        height: 5,
                      ),
                      notifier.apiResponseModel == null
                          ? Text("", style: TextStyle(height: 3))
                          : Text(
                              notifier.apiResponseModel.message ?? "",
                              style: TextStyle(
                                  color: notifier.apiResponseModel.status
                                      ? null
                                      : Colors.red,
                                  height: 3),
                            ),
                      Container(
                        height: 5,
                      ),
                      AppButton(
                        text: "Submit OTP",
                        onPressed: () async {
                          await notifier.submitOTP(
                              "${one.text}${two.text}${three.text}${four.text}${five.text}${six.text}");
                          if (notifier.apiResponseModel.status) {
                            MaterialPageRoute(
                              builder: (context) => SetPasswordScreen(),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class OTPBox extends StatelessWidget {
  final FocusNode nextFocusNode;
  final FocusNode previosFocusNode;
  final FocusNode currentFocusNode;
  final TextEditingController controller;
  OTPBox(
      {Key key,
      this.controller,
      this.currentFocusNode,
      this.nextFocusNode,
      this.previosFocusNode})
      : super(key: key);
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocusNode,
        onChanged: (x) {
          if (x.isNotEmpty) {
            FocusScope.of(context).requestFocus(nextFocusNode);
            return null;
          } else {
            FocusScope.of(context).requestFocus(previosFocusNode);
            return null;
          }
        },
        obscureText: true,
        textAlign: TextAlign.center,
        expands: false,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
        ),
      ),
    );
  }
}
