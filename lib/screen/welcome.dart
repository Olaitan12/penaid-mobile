import 'package:flutter/material.dart';
import 'package:penaid/models/welcome-screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  final List<WelcomeSliderModel> sliders = [
    WelcomeSliderModel(
        "Easier Loans",
        "Applying for loans got easier, with our loaning plans",
        "welcome-1.png"),
    WelcomeSliderModel(
        "Meet your goals",
        "That goal that you have always wanted to catch up with just go easier with penaid. You get a loan that suits your needs.",
        "welcome-2.png"),
    WelcomeSliderModel(
        "Easier Loans",
        "Applying for loans got easier, with our loaning plans",
        "welcome-3.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text("Skip"),
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              height: 400,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller:
                    PageController(viewportFraction: .9, initialPage: 0),
                // dragStartBehavior: DragStartBehavior.start,
                children: <Widget>[]..addAll(
                    sliders.map(
                      (e) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Image.asset("assets/images/${e.imageAssetUri}"),
                            Container(
                              alignment: Alignment.center,
                              width: 300,
                              child: Column(
                                children: [
                                  Text(e.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  Center(child: Text(e.description)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // verticalDirection: Ver,
              children: <Widget>[]
                ..addAll(sliders.asMap().entries.map((e) => Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ))),
            ))
          ],
        ),
      ),
    );
  }
}
