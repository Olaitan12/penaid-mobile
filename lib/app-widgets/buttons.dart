import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.width,
    this.height,
    this.marginBottom,
    this.marginTop,
    this.color,
  });
  final String text;
  final Function onPressed;
  final Color color;
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
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
