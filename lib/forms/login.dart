import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';

class LoginForm extends StatelessWidget {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          // height: MediaQuery.of(context).size.height,
          width: 30,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(left: 200, bottom: 70),
          child: RaisedButton(
            padding: EdgeInsets.zero,
            color: Colors.red,
            shape: Border.all(width: 1, color: Colors.red),
            textColor: Colors.white,
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          child: Form(
            key: _loginKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Enter email/phone number",
                        prefixIcon: Icon(Icons.person)),
                    controller: _usernameController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock)),
                    controller: _passwordController,
                  )
                ]),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: AppButton(text: "Login", onPressed: () {}))
      ]),
    );
  }
}
