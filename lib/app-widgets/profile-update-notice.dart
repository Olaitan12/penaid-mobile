import 'package:flutter/material.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';

// ignore: must_be_immutable
class UserProfileValidatorModel {
  final Object object;
  final IconData icon;
  final String message;
  UserProfileValidatorModel(this.object, this.icon, this.message);
}

// ignore: must_be_immutable
class ProfileUpdateNotice extends StatelessWidget {
  ///
  final UserModel userInfo;

  ProfileUpdateNotice(this.userInfo);
  List<UserProfileValidatorModel> listOfProfile;
  BuildContext _context;
  Widget build(BuildContext context) {
    _context = context;
    listOfProfile = [
      UserProfileValidatorModel(
          userInfo.employer, Icons.business, "Setup your employment details"),
      UserProfileValidatorModel(
          userInfo.nextOfKin, Icons.people, "Setup your next of kin details "),
      UserProfileValidatorModel(userInfo.retirement, Icons.card_travel,
          "Setup your retirement details"),
      UserProfileValidatorModel(
          userInfo.card, Icons.credit_card, "Setup your card details")
    ];
    List<String> personalInfo = [
      userInfo.email,
      userInfo.accountNumber,
      userInfo.bankCode,
      userInfo.address,
      userInfo.gender,
      userInfo.email,
    ];
    // debugPrint(listOfProfile.toString());
    return Container(
      padding: SCREEN_SPACE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          personalInfo.contains(null) ? getProfileUpdateNotice() : Container(),
          Container(
            height: 25,
          ),
          Text(
            "Complete your registration",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider()
        ]..addAll(
            listOfProfile.map(
              (e) => e.object == null
                  ? Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(e.icon),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.message,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ),
      ),
    );
  }

  Card getProfileUpdateNotice() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.info,
              size: 20,
              color: Colors.blue,
            ),
            Container(
              width: MediaQuery.of(_context).size.width - 110,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "We might withold payment till your profile is verified. Please complete your profile.",
                softWrap: true,
                overflow: TextOverflow.visible,
                // style: TextStyle(over),
              ),
            ),
            // ),
          ],
        ),
      ),
      margin: EdgeInsets.only(bottom: 5),
    );
  }
}

Widget myNoticeCard(String message) => Container(
      decoration: BoxDecoration(),
      child: Text(message ?? "No message"),
    );
