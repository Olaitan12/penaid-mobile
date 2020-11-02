import 'package:flutter/material.dart';
import 'package:penaid/models/message-text.dart';

class ColorText extends StatelessWidget {
  final int verticalMargin;
  final int horizontalMargin;
  final NotificationModel messageModel;

  ColorText(this.messageModel,
      {Key key, this.verticalMargin, this.horizontalMargin})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? 0, vertical: verticalMargin ?? 10),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          messageModel.message ?? "",
          style: TextStyle(color: messageModel.color ?? Colors.red),
        ),
      ),
    );
  }
}
