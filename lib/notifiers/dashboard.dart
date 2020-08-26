import 'package:flutter/material.dart';

class DashboardScreenNotifier extends ChangeNotifier {
  int activeIndex = 0;
  String currentTitle = "Dashboard";

  updatePage(int index) {
    activeIndex = index;
    notifyListeners();
  }

  updateTitle(String title) {
    currentTitle = title;
    notifyListeners();
  }
}
