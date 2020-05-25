import 'package:flutter/material.dart';

class OnboardProgress extends StatelessWidget {
  final String imageName;
  final double marginTop;
  final double marginBottom;

  OnboardProgress(this.imageName, {Key key, this.marginBottom, this.marginTop})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: marginBottom ?? MediaQuery.of(context).size.height / 6,
        top: marginTop ?? 30,
      ),
      child: Image.asset("assets/images/$imageName"),
    );
  }
}
