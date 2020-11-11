import 'package:flutter/material.dart';

class PageViewNotifier extends ChangeNotifier {
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
