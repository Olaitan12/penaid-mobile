import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/app-widgets/dashboard-profile.dart';
import 'package:penaid/app-widgets/loan-list.dart';
import 'package:penaid/app-widgets/profile-update-notice.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';

class DashboardHomeView extends StatefulWidget {
  // final UserModel user;
  _DashboardHomeView createState() => _DashboardHomeView();
}

class _DashboardHomeView extends State<DashboardHomeView> {
  // TabController _tabController;
  API _api = GetIt.I<API>();
  AppUserData _data = GetIt.I<AppUserData>();
  // UserModel user;
  initState() {
    getUserDetails();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      color: BACKGROUND_COLOR,
      child: _data.userData == null
          ? FutureBuilder(
              future: getUserDetails(),
              builder: _dashboardBuilder,
              initialData: APIResponseModel(true, "", _data.userData ?? null),
            )
          : DashboardWidgets(_data.userData),
    );
  }

  Widget _dashboardBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          APIResponseModel response = snapshot.data;
          if (response.status) {
            _data.setUserInfo(UserModel.fromJson(response.data));
            return DashboardWidgets(_data.userData);
          } else {
            return Container(
              padding: SCREEN_SPACE,
              child: Center(
                child:
                    ColorText(NotificationModel(response.message, Colors.red)),
              ),
            );
          }
        } else {
          return Center(
            child: ColorText(
                NotificationModel(snapshot.error.toString(), Colors.red)),
          );
        }
      } else {
        return Center(child: Image.asset("assets/images/loading.gif"));
      }
    } catch (e) {
      return Center(
        child: ErrorWidget(e),
      );
    }
  }

  Future<APIResponseModel> getUserDetails() async {
    return await _api.getRequest("user");
  }
}

class DashboardWidgets extends StatelessWidget {
  final UserModel data;
  DashboardWidgets(this.data);
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          MiniCardProfile(),
          ProfileUpdateNotice(data),
          Container(
            padding: SCREEN_SPACE.add(EdgeInsets.symmetric(vertical: 25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your loan history",
                  style: Theme.of(context).textTheme.headline5,
                ),
                LoanListTable(data.loans)
              ],
            ),
          )
        ],
      );
}
