import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/avatar.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard/account/about.dart';
import 'package:penaid/screen/dashboard/user-form.dart';
import 'package:penaid/screen/terms-condition.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';
import 'package:penaid/services/upload.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  UploadService uploadService;
  AppUserData _data = GetIt.I<AppUserData>();
  String uploadImagePath;
  // BuildContext _context;
  void initUploadService(BuildContext context) {
    uploadService = UploadService(
        context: context,
        userId: _data.accessData.userId,
        onSelected: (_) {},
        uploadDocumentType: UploadDocumentType.passport);
  }

  Widget build(BuildContext profileScreenContext) {
    initUploadService(profileScreenContext);
    List<ProfileListTileModel> _list = [
      ProfileListTileModel(
          "Personal Infomation", Icon(Icons.person), PersonalInformation()),
      ProfileListTileModel("About Penaid",
          ImageIcon(AssetImage("assets/icon.png")), AboutScreen()),
      ProfileListTileModel("Terms & Conditions", Icon(Icons.announcement),
          TermsAndConditionScreen()),
      ProfileListTileModel(
          "Contact us", Icon(Icons.headset_mic), ContactScreen())
    ];
    return Container(
      // color: Color.fromRGBO(128, 128, 128, .5),
      child: ListView(
        children: [
          Center(
            child: InkWell(
              onTap: uploadService.upload,
              child: ClientAvatar(
                size: 125,
                userId: _data.accessData.userId,
                uploadImagePath: uploadImagePath,
              ),
            ),
          ),
          Text(
            _data.accessData.clientName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200),
          ),
          Divider(
            height: 0,
          )
        ]
          ..addAll(_list.map(
            (e) => Container(
              color: Colors.white,
              child: Column(children: [
                ListTile(
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
                Divider(
                  height: 0,
                )
              ]),
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
