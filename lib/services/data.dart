import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/models/jwt.dart';

class AppUserData {
  JWTModel _accessData;
  UserModel _userInfo;

  get accessData => _accessData;
  get userData => _userInfo;
  setAccessData(JWTModel data) {
    this._accessData = data;
  }

  setUserInfo(UserModel data) {
    this._userInfo = data;
  }
  // AppUserData(this.accessData, this.user);
}
