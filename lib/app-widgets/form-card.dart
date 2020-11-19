import 'package:flutter/material.dart';
// import 'package:penaid/constants.dart';

class FormCard extends StatelessWidget {
  final Widget child;
  final IconData iconData;
  FormCard({this.child, this.iconData});
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 30, right: 30, top: 125, bottom: 20),
      color: Colors.grey[50], // BACKGROUND_COLOR,
      child: Card(
        semanticContainer: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: child),
      ),
    );
  }
}
