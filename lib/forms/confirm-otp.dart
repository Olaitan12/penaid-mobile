import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';

class OTPForm extends StatefulWidget {
  _OTPForm createState() => _OTPForm();
}

class _OTPForm extends State<OTPForm> {
  final nodeOne = FocusNode();
  final nodeTwo = FocusNode();
  final nodeThree = FocusNode();
  final nodeFour = FocusNode();
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/progress-step-two.png"),
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
                SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: null,
                      focusNode: nodeOne,
                      autofocus: true,
                      onChanged: (x) {
                        if (x.isNotEmpty) {
                          FocusScope.of(context).requestFocus(nodeTwo);
                          return null;
                        } else {
                          FocusScope.of(context).requestFocus(nodeOne);
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
                    )),
                SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: null,
                      focusNode: nodeTwo,
                      onChanged: (x) {
                        if (x.isNotEmpty) {
                          FocusScope.of(context).requestFocus(nodeThree);
                          return null;
                        } else {
                          FocusScope.of(context).requestFocus(nodeOne);
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
                    )),
                SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: null,
                      focusNode: nodeThree,
                      onChanged: (x) {
                        if (x.isNotEmpty) {
                          FocusScope.of(context).requestFocus(nodeFour);
                          return null;
                        } else {
                          FocusScope.of(context).requestFocus(nodeTwo);
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
                    )),
                SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: null,
                      focusNode: nodeFour,
                      onChanged: (x) {
                        if (x.isNotEmpty) {
                          FocusScope.of(context).requestFocus(nodeFour);
                          return null;
                        } else {
                          FocusScope.of(context).requestFocus(nodeThree);
                          return null;
                        }
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      expands: false,
                      decoration: InputDecoration(
                        counterText: "",
                      ),
                    ))
              ],
            ),
          ),
          Center(
            heightFactor: 5,
            child: Text("Didn't get OTP? Resend"),
          ),
          AppButton(
            text: "Confirm OTP",
            marginTop: 20,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
