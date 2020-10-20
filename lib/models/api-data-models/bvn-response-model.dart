import 'package:flutter/material.dart';

class BVNPayload {
  final String firstname;
  final String surname;
  final String phoneNumber;
  final String dateOfBirth;
  final String smsToken;
  final int otpId;
  final bool isRegisteredAppUser;

  BVNPayload(this.surname, this.firstname, this.phoneNumber, this.dateOfBirth,
      this.smsToken, this.otpId, this.isRegisteredAppUser);

  factory BVNPayload.fromJson(dynamic json) {
    debugPrint(json.toString());
    return BVNPayload(
        json["surname"] as String,
        json["firstname"] as String,
        json["phone"] as String,
        json["date_of_birth"] as String,
        json["smsToken"] as String,
        json["otpId"] as int,
        json["mobile_app_user"] as bool ?? false);
  }
}
