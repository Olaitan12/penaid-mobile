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
    this._userInfo = data;
  }
}
