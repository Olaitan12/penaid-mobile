import 'package:flutter/material.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/models/jwt.dart';

class AppUserData {
  JWTModel _accessData;
  UserModel _userInfo;

  JWTModel get accessData => _accessData;
  UserModel get userData => _userInfo;
  setAccessData(JWTModel data) {
    this._accessData = data;
  }

  setUserInfo(UserModel data) {
    debugPrint("=======Updating============");
    debugPrint("$data");
    debugPrint("=======Updating============");

    this._userInfo = data;
  }
  // AppUserData(this.accessData, this.user);
}
