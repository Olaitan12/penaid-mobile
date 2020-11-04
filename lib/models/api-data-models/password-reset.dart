import 'package:flutter/material.dart';

class ResetPasswordPayload {
  final String message;
  final String userId;
  final int otpId;
  ResetPasswordPayload(this.userId, this.otpId, this.message);

  factory ResetPasswordPayload.fromJson(dynamic json) {
    debugPrint(json.toString());
    return ResetPasswordPayload(
      json["uuid"] as String,
      json["otpId"] as int,
      json["message"] as String,
    );
  }
}
