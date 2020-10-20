import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/error-text.dart';

class SetPasswordScreen extends StatefulWidget {
  _SetPasswordScreen createState() => _SetPasswordScreen();
}

class _SetPasswordScreen extends State<SetPasswordScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  String _errorMessage = "";

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
              Center(
                child: Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              ErrorText(_errorMessage),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              TextFormField(
                controller: _confirmPassword,
                obscureText: true,
                onChanged: _passwordCombination,
                decoration: InputDecoration(hintText: "Confirm password"),
              ),
              // Builder(builder: (context) {
              ErrorText(_errorMessage),
              AppButton(
                text: "Set Password",
                marginTop: 0,
                onPressed: () async {
                  // await _verify(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _passwordCombination(String password) {
    if (password == null || _password.text == null) {
      _updateErrorMessage("Password combination incorrect");
    } else if (password == _password.text && _password.text != "") {
      _updateErrorMessage("message");
    }
  }

  void _updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }
}
