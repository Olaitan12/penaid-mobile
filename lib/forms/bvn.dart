import 'package:flutter/material.dart';
import 'package:penaid/app-widgets/buttons.dart';

class BVNForm extends StatefulWidget {
  final PageController pageController;
  BVNForm({Key key, this.pageController});
  _BVNForm createState() => _BVNForm();
}

class _BVNForm extends State<BVNForm> {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/progress-step-one.png"),
          Container(
              child: Icon(
            Icons.person,
            size: 100,
            color: Theme.of(context).primaryColor,
          )),
          Text(
            "Bank Verification Number",
            style: Theme.of(context).textTheme.headline2,
          ),
          TextFormField(
            controller: null,
            decoration: InputDecoration(hintText: "Enter your BVN"),
          ),
          AppButton(
            text: "Verify",
            marginTop: 20,
            onPressed: () {
              widget.pageController.animateTo(
                MediaQuery.of(context).size.width,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          )
        ],
      ),
    );
  }
}
