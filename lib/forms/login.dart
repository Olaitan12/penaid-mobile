import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/notifiers/dashboard.dart';
import 'package:penaid/notifiers/reset-password.dart';
import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/screen/reset-password.dart';
import 'package:penaid/services/api.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  //Variables
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  NotificationModel _notifyUser = NotificationModel(null, null);
  API _api = GetIt.I<API>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            fit: StackFit.loose,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, .8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                // child: ,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, .8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        width: 30,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.only(left: 200, bottom: 15),
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
                      Text("LOGIN",
                          style: Theme.of(context).textTheme.headline3),
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
                                ColorText(_notifyUser),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.refresh),
                                        GestureDetector(
                                          child: Text("Reset password"),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeNotifierProvider<
                                                          ResetPasswordNotifier>(
                                                    create: (context) =>
                                                        ResetPasswordNotifier(),
                                                    child:
                                                        ResetPasswordScreen(),
                                                  ),
                                                ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: AppButton(
                          text: "Login",
                          onPressed: () async {
                            // print(_usernameController.text + "  " + _passwordController.text);
                            var response =
                                await _api.postRequest("user/login", {
                              "username": _usernameController.text.trim(),
                              "password": _passwordController.text.trim()
                            });
                            if (response is APIResponseModel) {
                              if (response.status) {
                                _api.updateHeaderWithToken(
                                    response.data["token"]);
                                // print(response.data["token"]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            DashboardScreenNotifier>(
                                      create: (context) =>
                                          DashboardScreenNotifier(),
                                      child: DashboardScreen(),
                                    ),
                                  ),
                                );
                              } else {
                                _updateUser(
                                    NotificationModel(response.message, null));
                              }
                            } else {
                              _updateUser(
                                  NotificationModel(response.message, null));
                            }
                          },
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateUser(NotificationModel notice) {
    setState(() {
      _notifyUser = notice;
    });
  }
}
