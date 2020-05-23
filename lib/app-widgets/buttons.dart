import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key key,
      this.text,
      this.width,
      this.height,
      this.onPressed,
      this.marginBottom,
      this.marginTop});
  final String text;
  final Function onPressed;
  final double width;
  final double height;
  final double marginTop;
  final double marginBottom;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 5, bottom: marginBottom ?? 5),
      height: height ?? 45,
      width: width ?? MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(text),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
