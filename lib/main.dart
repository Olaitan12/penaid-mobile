import 'package:flutter/material.dart';
import 'package:penaid/notifiers/welcome-slider.dart';
import 'package:penaid/screen/welcome.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SliderNotifier sliderNotice = SliderNotifier();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penaid',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
        ),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
          headline1:
              TextStyle(fontSize: 32, fontWeight: FontWeight.w600, height: 3),
          headline2:
              TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 3),
          headline3:
              TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 2),
          headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(fontSize: 16),
          bodyText2: TextStyle(fontSize: 14),
        ),
      ),
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: ChangeNotifierProvider<SliderNotifier>.value(
          value: sliderNotice,
          child: WelcomeScreen(slideNotice: sliderNotice),
        ),
        title: Text('Getting the app ready for you...'),
        image: Image.asset('assets/full-logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.deepOrange,
      ),
    );
  }
}
