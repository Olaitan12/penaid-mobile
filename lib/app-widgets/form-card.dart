import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/circle-container.dart';
import 'package:penaid/constants.dart';

class FormCard extends StatelessWidget {
  final Widget child;
  final IconData iconData;
  FormCard({this.child, this.iconData});
  Widget build(BuildContext context) {
    return Container(
        padding: SCREEN_SPACE,
        color: Colors.grey[10], // BACKGROUND_COLOR,
        child: Center(
          child: SizedBox(
            width: 300,
            height: 450,
            child: Stack(children: [
              Card(
                margin: EdgeInsets.only(top: 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: child,
                ),
              ),
              RoundContainer(
                margin: EdgeInsets.only(left: 105),
                size: 90,
                child: Icon(
                  iconData,
                  size: 90,
                  color: Colors.orange,
                ),
              )
            ]),
          ),
        ));
  }
}
