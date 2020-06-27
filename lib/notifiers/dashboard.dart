import 'package:flutter/material.dart';

class DashboardScreenNotifier extends ChangeNotifier {
  int activeIndex = 0;

  slide(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
