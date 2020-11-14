import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/buttons.dart';
import 'package:penaid/app-widgets/loan-list.dart';
import 'package:penaid/app-widgets/pop-up.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/api-data-models/user.dart';
import 'package:penaid/models/jwt.dart';
import 'package:penaid/services/api.dart';

class DashboardHomeView extends StatefulWidget {
  final JWTModel user;
  _DashboardHomeView createState() => _DashboardHomeView();
  DashboardHomeView(this.user);
}

class _DashboardHomeView extends State<DashboardHomeView> {
  // TabController _tabController;
  API _api = GetIt.I<API>();
  UserModel user;
  initState() {
    //  _tabController = TabController(length: 3, vsync: this);
    getUserDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: BACKGROUND_COLOR,
      child: Stack(
        children: [
          ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(
                    children: <Widget>[
                      Row(children: [
                        Text(
                          "Next payment",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ]),
                      Text(
                        "₦0.00",
                        style: TextStyle(
                            fontSize: 32,
                            height: 2,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.user.clientName ?? "Client Name",
                            style: TextStyle(height: 2),
                          ),
                          Image.asset(
                            "assets/full-logo.png",
                            width: 32,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 25, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your loan history",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    LoanListTable(user == null ? null : user.loans)
                  ],
                ),
              )
            ],
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   color: Color.fromRGBO(230, 230, 230, .5),
          //   child: Center(child: CircularProgressIndicator()),
          // )
        ],
      ),
    );
  }

  Future getUserDetails() async {
    var response = await _api.getRequest("user");
    if (response.status) {
      setState(() {
        user = UserModel.fromJson(response.data);
      });
    } else {
      // Builder(builder: (context) =>);
      showDialog(
          builder: (context) => PopUpScreen(
              actionButton: AppButton(
                  text: "ok",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              screenMessage: response.message),
          context: context);
    }
  }
}
