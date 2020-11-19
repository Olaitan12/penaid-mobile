import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/avatar.dart';
import 'package:penaid/services/data.dart';

// ignore: must_be_immutable
class MiniCardProfile extends StatelessWidget {
  AppUserData _data = GetIt.I<AppUserData>();
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 45),
      padding: EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.white),
          boxShadow: [BoxShadow(blurRadius: .5, color: Colors.grey)],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(0))),
      width: MediaQuery.of(context).size.width,
      // height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(_data.accessData.surname),
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(1),
            child: ClientAvatar(
              size: 35,
              width: 45,
              height: 45,
              userId: _data.accessData.userId,
            ),
          )
        ],
      ),
    );
  }
}
