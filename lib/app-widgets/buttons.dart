import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({Key key, this.text, this.width, this.height, this.onPressed});
  final String text;
  final Function onPressed;
  final double width;
  final double height;

  Widget build(BuildContext context) {
    return SizedBox(
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
