import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/notifiers/reset-password.dart';
import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/screen/reset-password.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';
import 'package:penaid/services/jwt.dart';
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
  bool _hiddenPassword = true;
  API _api = GetIt.I<API>();
  AppUserData _data = GetIt.I<AppUserData>();

  void _togglePasswordVisibility() {
    setState(() {
      _hiddenPassword = !_hiddenPassword;
    });
  }

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
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, .98),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("LOGIN",
                          style: Theme.of(context).textTheme.headline3),
                      Container(
                        child: Form(
                          key: _loginKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter phone number",
                                      labelText: "Phone number",
                                      prefixIcon:
                                          Icon(Icons.person_outline_outlined)),
                                  controller: _usernameController,
                                ),
                                Container(
                                  height: 5,
                                ),
                                TextField(
                                  obscureText: _hiddenPassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Enter password",
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                      icon: _hiddenPassword
                                          ? Icon(Icons.remove_red_eye_outlined)
                                          : ImageIcon(AssetImage(
                                              "assets/icons/hide-password.png")),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    prefixIcon:
                                        Icon(Icons.lock_outline_rounded),
                                  ),
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
                                _updateUser(NotificationModel(null, null));
                                JWTDecoder jwt = JWTDecoder();
                                _data.setAccessData(
                                    jwt.parseJWT(response.data["token"]));
                                _data.setUserInfo(null);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                            PageViewNotifier>(
                                      create: (context) => PageViewNotifier(),
                                      child: DashboardScreen(
                                          jwt.parseJWT(response.data["token"])),
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
