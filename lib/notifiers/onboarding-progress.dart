import 'package:flutter/material.dart';
import 'package:penaid/forms/bvn.dart';
import 'package:penaid/forms/confirm-otp.dart';

class OnboardingProgressNotifier extends ChangeNotifier {
  int activeIndex = 0;
  final List<dynamic> forms = [BVNForm(), OTPForm()];
  progress(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
