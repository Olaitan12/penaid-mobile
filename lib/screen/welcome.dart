import 'package:flutter/material.dart';
import 'package:penaid/notifiers/welcome-slider.dart';
import 'package:penaid/screen/login-signup.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key key, this.slideNotice}) : super(key: key);

  final SliderNotifier slideNotice;

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginSignup()));
                  },
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.headline5,
                  )),
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              height: 400,
              child: PageView(
                scrollDirection: Axis.horizontal,
                onPageChanged: slideNotice.slide,
                controller:
                    PageController(viewportFraction: .9, initialPage: 0),
                // dragStartBehavior: DragStartBehavior.start,
                children: <Widget>[]..addAll(
                    slideNotice.sliders.map(
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
            Consumer(
              builder: (context, SliderNotifier data, child) => Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // verticalDirection: Ver,
                children: <Widget>[]..addAll(
                    slideNotice.sliders.asMap().entries.map((e) => Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: data.activeIndex == e.key
                                ? Colors.orange
                                : Colors.transparent,
                            border: Border.all(width: 1, color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
