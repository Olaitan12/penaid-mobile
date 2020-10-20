import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorMessage;
  final int verticalMargin;
  final int horizontalMargin;
  ErrorText(this.errorMessage,
      {Key key, this.verticalMargin, this.horizontalMargin})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin ?? 0, vertical: verticalMargin ?? 10),
        child: Text(
          errorMessage ?? "",
          style: TextStyle(color: Colors.red),
        ));
  }
}
