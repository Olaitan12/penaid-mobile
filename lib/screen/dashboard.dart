import 'package:flutter/material.dart';
import 'package:penaid/notifiers/dashboard.dart';
import 'package:penaid/screen/dashboard/calculator.dart';
import 'package:penaid/screen/dashboard/card-view.dart';
import 'package:penaid/screen/dashboard/home.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0);

  final List<DashboardScreenModel> pages = [
    DashboardScreenModel(0, "Dashboard", DashboardHomeView(), Icons.home),
    DashboardScreenModel(1, "Card Manager", CardManager(), Icons.credit_card),
    DashboardScreenModel(2, "Loan History", CalculatorView(), Icons.history),
    DashboardScreenModel(
        3, "Profile settings", CalculatorView(), Icons.settings),
  ];
  DashboardScreenNotifier _notifier;
  Widget build(BuildContext context) {
    _notifier = Provider.of<DashboardScreenNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Consumer<DashboardScreenNotifier>(
            builder: (context, data, child) => Text(data.currentTitle)),
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
                      _changePage(e.index, e.title);
                    },
                  ),
                ),
              )),
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
  final IconData icons;
  final String title;
  final int index;
  DashboardScreenModel(
    this.index,
    this.title,
    this.screen,
    this.icons,
  );
}
