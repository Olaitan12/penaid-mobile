import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/models/api-data-models/bvn-response-model.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/services/api.dart';

class OTPNotifier extends ChangeNotifier {
  String _errorMessage;
  String _otpSentMessage;
  bool _loading = false;
  bool get loading => _loading;
  BVNPayload _bvnPayload;
  String get errorMessage => _errorMessage;
  String get otpSentMessage => _otpSentMessage;
  BVNPayload get bvnPayload => _bvnPayload;
  API _api = GetIt.I<API>();
  APIResponseModel apiResponseModel;

  setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  setBVNPayload(BVNPayload payload) {
    _bvnPayload = payload;
    // sendOtpViaText();
    // notifyListeners();
  }

  Future<void> submitOTP(
    String otp,
  ) async {
    if (otp != null && otp.length != 6) {
      apiResponseModel = APIResponseModel(false, "Invalid operation", null);
    } else {
      debugPrint(otp);
      debugPrint(bvnPayload.otpId.toString());
      apiResponseModel = await _api
          .postRequest("verify/otp", {"otpId": bvnPayload.otpId, "otp": otp});
    }

    notifyListeners();
  }

  Future<void> sendOtpViaText() async {
    apiResponseModel = await _api
        .postRequest("verify/phone_number", {"smsToken": bvnPayload.smsToken});

    notifyListeners();
  }
}
