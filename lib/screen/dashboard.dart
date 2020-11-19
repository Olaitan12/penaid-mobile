import 'package:flutter/material.dart';
// import 'package:penaid/app-widgets/dashboard-profile.dart';
import 'package:penaid/constants.dart';
import 'package:penaid/models/jwt.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard/calculator.dart';
import 'package:penaid/screen/dashboard/card-view.dart';
import 'package:penaid/screen/dashboard/home.dart';
import 'package:penaid/screen/dashboard/account.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  final JWTModel user;

  _DashboardScreen createState() => _DashboardScreen();

  DashboardScreen(this.user);
}

class _DashboardScreen extends State<DashboardScreen> {
  PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0);

  List<DashboardScreenModel> pages;

  PageViewNotifier _notifier;
  Widget build(BuildContext context) {
    pages = [
      DashboardScreenModel(0, "Dashboard", DashboardHomeView(), Icons.home),
      DashboardScreenModel(1, "Card Manager", CardManager(), Icons.credit_card),
      DashboardScreenModel(2, "Loan History", CalculatorView(), Icons.history),
      DashboardScreenModel(
          3, "Profile settings", ProfileScreen(), Icons.person_pin),
    ];
    _notifier = Provider.of<PageViewNotifier>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: appBarHeight(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.orange,
        title: Container(
          child: Consumer<PageViewNotifier>(
            builder: (context, data, child) => Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                data.currentTitle,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: BACKGROUND_COLOR,
        child: PageView(
          scrollDirection: Axis.horizontal,
          pageSnapping: false,
          onPageChanged: _changePage,
          controller: _pageController,
          children: []..addAll(pages.map((page) => page.screen).toList()),
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 30,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: []..addAll(
                pages.map(
                  (e) => Consumer<PageViewNotifier>(
                    builder: (context, data, child) => IconButton(
                      color: e.index == data.activeIndex
                          ? Theme.of(context).primaryColor
                          : null,
                      icon: Icon(e.icon),
                      onPressed: () {
                        _changePage(e.index, e.title);
                      },
                    ),
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }

  void _changePage(int index, [String title]) {
    _pageController.jumpToPage(index);
    _notifier.updatePage(index);
    title != null
        ? _notifier.updateTitle(title)
        : _notifier.updateTitle(_getTitle(index));
  }

  String _getTitle(int index) {
    List<DashboardScreenModel> page =
        pages.where((e) => e.index == index).toList();
    return page[0].title;
  }
}

class DashboardScreenModel {
  final Widget screen;
  final IconData icon;
  final String title;
  final int index;
  DashboardScreenModel(
    this.index,
    this.title,
    this.screen,
    this.icon,
  );
}
