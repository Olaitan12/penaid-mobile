import 'package:flutter/material.dart';

class PageViewNotifier extends ChangeNotifier {
  int activeIndex = 0;
  String currentTitle = "Dashboard";
  PageController pageController =
      PageController(viewportFraction: 1, initialPage: 0);
  updatePage(int index) {
    activeIndex = index;
    notifyListeners();
  }

  updateTitle(String title) {
    currentTitle = title;
    notifyListeners();
  }
}
