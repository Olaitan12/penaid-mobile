import 'package:flutter/material.dart';

class BVNPayload {
  final String firstname;
  final String surname;
  final String phoneNumber;
  final String dateOfBirth;
  final String smsToken;
  final String bvn;
  final int otpId;
  final bool isRegisteredAppUser;

  BVNPayload(this.surname, this.firstname, this.phoneNumber, this.dateOfBirth,
      this.smsToken, this.otpId, this.isRegisteredAppUser, this.bvn);

  factory BVNPayload.fromJson(dynamic json) {
    debugPrint(json.toString());
    return BVNPayload(
      json["surname"] as String,
      json["firstname"] as String,
      json["phone"] as String,
      json["date_of_birth"] as String,
      json["smsToken"] as String,
      json["otpId"] as int,
      json["mobile_app_user"] as bool ?? false,
      json["bvn"] as String,
    );
  }
  factory BVNPayload.fromPaystackJson(dynamic json) {
    debugPrint(json.toString());
    return BVNPayload(
      json["last_name"] as String,
      json["first_name"] as String,
      json["mobile"] as String,
      json["dob"] as String,
      json["smsToken"] as String,
      json["otpId"] as int,
      json["mobile_app_user"] as bool ?? false,
      json["bvn"] as String,
    );
  }

  // Map<String, dynamic> toMap(BVNPayload payload) {
  //   return {
  //     "firstname": payload.firstname,
  //     "firstname": payload.firstname,
  //   };
  // }
}
