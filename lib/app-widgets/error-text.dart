import 'package:flutter/material.dart';

class ErrorWidget extends StatefulWidget {
  final String errorMessage;
  ErrorWidget(this.errorMessage, {Key key}) : super(key: key);
  _ErrorWidget createState() => _ErrorWidget();
}

class _ErrorWidget extends State<ErrorWidget> {
  Widget build(BuildContext context) {
    return Text(
      widget.errorMessage,
      style: TextStyle(color: Colors.red),
    );
  }
}
