import 'package:flutter/material.dart';
import 'package:penaid/notifiers/dashboard.dart';
import 'package:penaid/screen/dashboard/calculator.dart';
import 'package:penaid/screen/dashboard/home.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0);

  final List<DashboardScreenModel> pages = [
    DashboardScreenModel(DashboardHomeView(), Icons.home, 0),
    DashboardScreenModel(CalculatorView(), Icons.credit_card, 1),
    DashboardScreenModel(CalculatorView(), Icons.history, 2),
    DashboardScreenModel(CalculatorView(), Icons.settings, 3),
  ];
  DashboardScreenNotifier _notifier;
  Widget build(BuildContext context) {
    print("again?");
    _notifier = Provider.of<DashboardScreenNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Dashboard"),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: false,
        onPageChanged: _changePage,
        controller: _pageController,
        children: []..addAll(pages.map((page) => page.screen).toList()),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: []..addAll(pages.map(
                (e) => Consumer<DashboardScreenNotifier>(
                  builder: (context, data, child) => IconButton(
                    color: e.index == data.activeIndex
                        ? Theme.of(context).primaryColor
                        : null,
                    icon: Icon(e.icons),
                    onPressed: () {
                      _changePage(e.index);
                    },
                  ),
                ),
              )),
          ),
        ),
      ],
    );
  }

  void _changePage(int index) {
    _pageController.jumpToPage(index);
    _notifier.slide(index);
  }
}

class DashboardScreenModel {
  final Widget screen;
  final IconData icons;
  final int index;
  DashboardScreenModel(this.screen, this.icons, this.index);
}
