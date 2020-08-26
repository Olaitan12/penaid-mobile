import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';
// import 'package:penaid/notifiers/dashboard.dart';
// import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/services/api.dart';
// import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  API _api = API();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, .8),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
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
                        hintText: "Enter phone number or email",
                        prefixIcon: Icon(Icons.person)),
                    controller: _usernameController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock)),
                    controller: _passwordController,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.refresh),
                        Container(child: Text(" Reset password")),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: AppButton(
            text: "Login",
            onPressed: () async {
              var apiResponse = await _api.postRequest("user/login", {
                "username": _usernameController.text,
                "password": _passwordController.text
              });
              print(apiResponse);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         ChangeNotifierProvider<DashboardScreenNotifier>(
              //       create: (context) => DashboardScreenNotifier(),
              //       child: DashboardScreen(),
              //     ),
              //   ),
              // );
            },
          ),
        )
      ]),
    );
  }
}
