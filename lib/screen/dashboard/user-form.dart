import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
import 'package:penaid/app-widgets/circle-container.dart';
import 'package:penaid/notifiers/page-view.dart';
import 'package:penaid/screen/dashboard.dart';
import 'package:penaid/forms/bank-detail.dart';
import 'package:penaid/forms/bio.dart';
import 'package:penaid/forms/contact-detail.dart';
import 'package:penaid/forms/employment.dart';
import 'package:penaid/forms/next-of-kin.dart';
import 'package:penaid/forms/retirement.dart';
// import 'package:penaid/services/data.dart';
import 'package:penaid/services/text-form-block.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  _PersonalInformation createState() => _PersonalInformation();
}

class _PersonalInformation extends State<PersonalInformation> {
  PageController pageController;
  List<DashboardScreenModel> pages;
  PageViewNotifier _notifier;

  Widget build(BuildContext personalInformationContext) {
    pages = [
      DashboardScreenModel(0, "Personal Information", BioDataScreen(), null),
      DashboardScreenModel(1, "Contact Information", ContactInfoScreen(), null),
      DashboardScreenModel(2, "Bank details", BankDetails(), null),
      DashboardScreenModel(3, "Retirement program", RetirementForm(), null),
      DashboardScreenModel(4, "Employment History", EmploymentForm(), null),
      DashboardScreenModel(5, "Next of kin", NextOfKinForm(), null),
    ];
    double appBarHeight = MediaQuery.of(context).size.height / 8;
    _notifier = Provider.of<PageViewNotifier>(personalInformationContext,
        listen: false);
    pageController = _notifier.pageController;
    return Provider<TextFormBloc>(
      create: (context) => TextFormBloc(),
      dispose: (context, value) => value.dispose(),
      child: Scaffold(
        appBar: PreferredSize(
            child: Consumer<PageViewNotifier>(builder: (context, data, child) {
              int currentFormIndex = data.activeIndex < pages.length
                  ? data.activeIndex + 1
                  : pages.length;
              int nextFormIndex = currentFormIndex == pages.length
                  ? currentFormIndex
                  : currentFormIndex + 1;
              return AppBar(
                  elevation: 2,
                  toolbarHeight: appBarHeight,
                  backgroundColor: Colors.grey[50],
                  title: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RoundContainer(
                            radius: 2,
                            color: Colors.orange,
                            size: 50,
                            child: Center(
                              child: Text(
                                "$currentFormIndex of ${pages.length}",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  shadows: [Shadow(color: Colors.black87)],
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    pages[data.activeIndex].title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "Next: " +
                                        pages[nextFormIndex > pages.length
                                                ? pages.length - 1
                                                : nextFormIndex - 1]
                                            .title,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ]),
                          ),
                        ]),
                  ));
            }),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              appBarHeight,
            )),
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
                FlatButton(
                  onPressed: (_notifier.activeIndex < pages.length - 1)
                      ? () {
                          debugPrint(value.activeIndex.toString());
                          int index = _notifier.activeIndex + 1;
                          _changePage(index);
                        }
                      : null,
                  textColor: Colors.white,
                  color: Colors.orange,
                  disabledColor: Colors.orange[100],
                  child: Text("Next"),
                  // textColor: ,
                ),
              ],
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
      ),
    );
  }

  void _changePage(int index, [String title]) {
    pageController.jumpToPage(index);
    _notifier.updatePage(index);
  }

  void dispose() {
    super.dispose();
  }
}
