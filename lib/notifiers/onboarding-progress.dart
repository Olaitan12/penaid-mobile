import 'package:flutter/material.dart';

class OnboardingProgressNotifier extends ChangeNotifier {
  int activeIndex = 0;
  final List<Widget> forms = [];
  progress(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
