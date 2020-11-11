import 'package:flutter/material.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/screen/dashboard/profile/bio.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  _PersonalInformation createState() => _PersonalInformation();
}

class _PersonalInformation extends State<PersonalInformation> {
  PageController pageController =
      PageController(viewportFraction: 1, initialPage: 0);
  final List<DashboardScreenModel> pages = [
    DashboardScreenModel(
        0, "Personal Information", BioDataScreen(), Icons.home),
  ];
  PageViewNotifier _notifier;

  Widget build(BuildContext personalInformationContext) {
    _notifier = Provider.of<PageViewNotifier>(personalInformationContext,
        listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_notifier.activeIndex].title),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: false,
        onPageChanged: _changePage,
        controller: pageController,
        children: []..addAll(pages.map((page) => page.screen).toList()),
      ),
    );
  }

  void _changePage(int index, [String title]) {
    pageController.jumpToPage(index);
    _notifier.updatePage(index);
  }
}
