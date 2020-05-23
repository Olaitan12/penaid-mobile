import 'package:flutter/material.dart';
import 'package:penaid/models/welcome-slider.dart';

class SliderNotifier extends ChangeNotifier {
  int activeIndex = 0;
  final List<WelcomeSliderModel> sliders = [
    WelcomeSliderModel(
      "Easier Loans",
      "Applying for loans got easier, with our loaning plans",
      "welcome-1.png",
    ),
    WelcomeSliderModel(
      "Meet your goals",
      "That goal that you have always wanted to catch up with just go easier with penaid. You get a loan that suits your needs.",
      "welcome-2.png",
    ),
    WelcomeSliderModel(
      "Easier Loans",
      "Applying for loans got easier, with our loaning plans",
      "welcome-3.png",
    ),
  ];
  slide(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
