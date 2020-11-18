import 'package:flutter/material.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/screen/dashboard/account/bio.dart';
import 'package:penaid/screen/dashboard/account/employment.dart';
import 'package:penaid/screen/dashboard/account/next-of-kin.dart';
import 'package:penaid/screen/dashboard/account/retirement.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  _PersonalInformation createState() => _PersonalInformation();
}

class _PersonalInformation extends State<PersonalInformation> {
  PageController pageController;
  final List<DashboardScreenModel> pages = [
    DashboardScreenModel(0, "Personal Information", BioDataScreen(), null),
    DashboardScreenModel(3, "Next of kin", NextOfKinForm(), null),
    DashboardScreenModel(1, "Employment History", EmploymentForm(), null),
    DashboardScreenModel(2, "Retirement program", RetirementForm(), null),
  ];
  PageViewNotifier _notifier;

  Widget build(BuildContext personalInformationContext) {
    _notifier = Provider.of<PageViewNotifier>(personalInformationContext,
        listen: false);
    pageController = _notifier.pageController;
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Consumer<PageViewNotifier>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                onPressed: value.activeIndex > 0
                    ? () {
                        debugPrint(value.activeIndex.toString());
                        int index = _notifier.activeIndex - 1;
                        _changePage(index);
                      }
                    : null,
                textColor: Colors.orange,
                child: Text("Back"),
              ),
              OutlineButton(
                onPressed: (_notifier.activeIndex < 3)
                    ? () {
                        debugPrint(value.activeIndex.toString());
                        int index = _notifier.activeIndex + 1;
                        _changePage(index);
                      }
                    : null,
                textColor: Colors.orange,
                child: Text("Next"),
                // textColor: ,
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Consumer<PageViewNotifier>(
            builder: (context, data, child) =>
                Text(pages[data.activeIndex].title),
          ),
        ),
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
