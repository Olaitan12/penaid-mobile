import 'package:flutter/material.dart';

class PopUpScreen extends StatelessWidget {
  final String screenMessage;
  final Widget actionButton;
  final Icon icon;
  PopUpScreen(
      {@required this.actionButton, @required this.screenMessage, this.icon});
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            // margin: EdgeInsets.only(top: 100),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 35,
              height: 170,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      screenMessage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(bottom: 150),
            child: icon,
          ),
        ),
        Center(
          child:
              Container(margin: EdgeInsets.only(top: 150), child: actionButton),
        ),
      ],
    );
  }
}
