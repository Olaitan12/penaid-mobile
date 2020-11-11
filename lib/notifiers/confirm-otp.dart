import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/models/api-data-models/bvn-response-model.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/api-data-models/password-reset.dart';
import 'package:penaid/services/api.dart';

class OTPNotifier extends ChangeNotifier {
  String _errorMessage;
  String _otpSentMessage;
  bool _loading = false;
  bool get loading => _loading;
  BVNPayload _bvnPayload;
  ResetPasswordPayload _resetPasswordPayload;
  String get errorMessage => _errorMessage;
  String get otpSentMessage => _otpSentMessage;
  BVNPayload get bvnPayload => _bvnPayload;
  ResetPasswordPayload get resetPasswordPayload => _resetPasswordPayload;
  API _api = GetIt.I<API>();
  APIResponseModel apiResponseModel;

  setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  setBVNPayload(BVNPayload payload) {
    _bvnPayload = payload;
  }

  setResetPasswordPayload(ResetPasswordPayload payload) {
    _resetPasswordPayload = payload;
  }

  setPasswordResetPayload(ResetPasswordPayload payload) {
    _resetPasswordPayload = payload;
  }

  Future<void> submitOTP(
    String otp,
  ) async {
    var payload;
    if (otp.isEmpty || otp.length != 6) {
      apiResponseModel = APIResponseModel(false, "Invalid operation", null);
    } else {
      // debugPrint(otp);
      if (bvnPayload != null) {
        payload = {"otpId": bvnPayload.otpId, "otp": otp};
        debugPrint(bvnPayload.otpId.toString());
        // debugPrint("bvnPayload");
      } else if (_resetPasswordPayload != null) {
        payload = {"otpId": resetPasswordPayload.otpId, "otp": otp};
        debugPrint(resetPasswordPayload.otpId.toString());
        // debugPrint("resetPasswordPayload");
      }
      debugPrint(payload.toString());
      apiResponseModel = await _api.postRequest("verify/otp", payload);
    }

    notifyListeners();
  }

  Future<void> sendOtpViaText() async {
    apiResponseModel = await _api
        .postRequest("verify/phone_number", {"smsToken": bvnPayload.smsToken});

    notifyListeners();
  }
}
