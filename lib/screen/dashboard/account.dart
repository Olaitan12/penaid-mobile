import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penaid/app-widgets/avatar.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard/profile/about.dart';
import 'package:penaid/screen/personal-details.dart';
import 'package:penaid/screen/terms-condition.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  AppUserData _data = GetIt.I<AppUserData>();
  String uploadImagePath;
  // BuildContext _context;
  Widget build(BuildContext profileScreenContext) {
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
              onTap: _showDialog,
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

  Future<void> pickFile(ImageSource source) async {
    API api = GetIt.I<API>();
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.front);
    setState(() {
      uploadImagePath = file.path;
    });
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: 150,
              height: 100,
              child: Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Uploading "), CircularProgressIndicator()],
              )),
            ),
          );
        });
    try {
      var res =
          await api.uploadImage(file.path, _data.accessData.userId, "photo");
      debugPrint(res);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
    // if (Platform.isIOS) {
    // } else {}
  }

  _showDialog() {
    showDialog(
        builder: (context) {
          return Center(
              child: SizedBox(
            width: 250,
            height: 150,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(30),
                width: 250,
                height: 100,
                child: Column(
                  children: [
                    Text("Take a photo from:"),
                    Container(
                      child: Row(
                        children: [
                          FlatButton(
                              onPressed: () {
                                pickFile(ImageSource.gallery);
                              },
                              child: Text("Gallery")),
                          FlatButton(
                              onPressed: () {
                                pickFile(ImageSource.camera);
                              },
                              child: Text("Camera")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        },
        context: context);
  }
}

class ProfileListTileModel {
  final Widget leadingIcon;
  final String title;
  final Widget screen;
  ProfileListTileModel(this.title, this.leadingIcon, this.screen);
}
