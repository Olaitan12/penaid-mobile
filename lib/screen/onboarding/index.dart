import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingIndexScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: null,
      child: Column(
        children: [
          Consumer(
            builder: (BuildContext context, value, Widget child) {
              return null;
            },
          ),
          PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: null,
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
