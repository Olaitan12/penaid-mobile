import 'package:flutter/material.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard/profile/about.dart';
import 'package:penaid/screen/personal-details.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext profileScreenContext) {
    List<ProfileListTileModel> _list = [
      ProfileListTileModel(
          "Personal Infomation", Icon(Icons.person), PersonalInformation()),
      ProfileListTileModel("About Penaid",
          ImageIcon(AssetImage("assets/icon.png")), AboutScreen())
    ];
    return Container(
      // color: Color.fromRGBO(128, 128, 128, .5),
      child: ListView(
        children: []
          ..addAll(_list.map(
            (e) => ListTile(
              leading: e.leadingIcon,
              title: Text(e.title ?? "Title"),
              trailing: Icon(Icons.arrow_forward_ios),
              dense: true,
              onTap: () {
                if (e.screen is PersonalInformation) {
                  Navigator.push(
                    profileScreenContext,
                    MaterialPageRoute(
                      builder: (profileScreenContext) =>
                          ChangeNotifierProvider<PageViewNotifier>(
                        create: (context) => PageViewNotifier(),
                        child: PersonalInformation(),
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                      profileScreenContext,
                      MaterialPageRoute(
                          builder: (profileScreenContext) => e.screen));
                }
              },
            ),
          ))
          ..add(
            ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                dense: true,
                title: Text(
                  "Sign out",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(profileScreenContext);
                }),
          ),
      ),
    );
  }
}

class ProfileListTileModel {
  final Widget leadingIcon;
  final String title;
  final Widget screen;
  ProfileListTileModel(this.title, this.leadingIcon, this.screen);
}
