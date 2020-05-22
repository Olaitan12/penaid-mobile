import 'package:flutter/material.dart';
import 'package:penaid/screen/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penaid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1:
              TextStyle(fontSize: 32, fontWeight: FontWeight.w600, height: 3),
          headline2:
              TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 3),
          headline3:
              TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 3),
          headline4:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 3),
          headline5:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 3),
          bodyText1: TextStyle(fontSize: 16),
          bodyText2: TextStyle(fontSize: 14),
        ),
      ),
      home: WelcomeScreen(title: ''),
    );
  }
}
