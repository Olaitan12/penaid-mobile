import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/avatar.dart';
import 'package:penaid/app-widgets/color-text.dart';
import 'package:penaid/app-widgets/loan-list.dart';
import 'package:penaid/app-widgets/profile-update-notice.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/models/api.dart';
import 'package:penaid/models/message-text.dart';
import 'package:penaid/services/api.dart';
import 'package:penaid/services/data.dart';
// import 'package:penaid/services/data.dart';

class DashboardHomeView extends StatefulWidget {
  // final UserModel user;
  _DashboardHomeView createState() => _DashboardHomeView();
  // DashboardHomeView(this.user);
}

class _DashboardHomeView extends State<DashboardHomeView> {
  // TabController _tabController;
  API _api = GetIt.I<API>();
  AppUserData _data = GetIt.I<AppUserData>();
  // UserModel user;
  initState() {
    //  _tabController = TabController(length: 3, vsync: this);
    getUserDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: BACKGROUND_COLOR,
      child: FutureBuilder(
        future: getUserDetails(),
        builder: _dashboardBuilder,
        initialData: APIResponseModel(true, "", _data.userData ?? null),
      ),
    );
  }

  Widget _dashboardBuilder(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    try {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          APIResponseModel response = snapshot.data;
          if (response.status) {
            var user = UserModel.fromJson(response.data);
            _data.setUserInfo(user);
            return ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 45),
                  padding: EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      // border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: MediaQuery.of(context).size.width,
                  // height: 65,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(_data.accessData.clientName),
                      Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(1),
                          child: ClientAvatar(
                            size: 35,
                            width: 45,
                            height: 45,
                            userId: _data.accessData.userId,
                          ))
                    ],
                  ),
                ),
                ProfileUpdateNotice(_data.userData),
                Container(
                  padding: SCREEN_SPACE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your loan history",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      LoanListTable(_data.userData.loans)
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container(
                padding: SCREEN_SPACE,
                child: Center(
                  child: ColorText(
                      NotificationModel(response.message, Colors.red)),
                ));
          }
        } else {
          return Center(
            child: ColorText(
                NotificationModel(snapshot.error.toString(), Colors.red)),
          );
        }
      } else {
        return Center(child: CircularProgressIndicator());
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

  // Widget getNextPayment(List<LoanModel> loanList) {
  //   // loans != null ? loans.map((loan) => null) : Container(),
  //   if (loanList != null) {
  //     List<Widget> nextPayment;

  //     for (var loan in loanList) {
  //       nextPayment.add();
  //     }

  //     return Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height / 4,
  //       child: ListView(
  //         scrollDirection: Axis.horizontal,
  //         children: nextPayment ?? [NextPayment(null)],
  //       ),
  //     );
  //   } else {
  //     return NextPayment(null);
  //   }
  // }
}
