import 'package:flutter/material.dart';
import 'package:penaid/constants.dart';

class AboutScreen extends StatelessWidget {
  Widget build(BuildContext aboutScreenContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Container(
          padding: SCREEN_SPACE,
          child: ListView(
            children: [
              Image(
                image: AssetImage("assets/full-logo.png"),
              )
            ],
          ),
        ));
  }
}
