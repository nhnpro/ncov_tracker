import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virus_corona_tracker/core/news.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/pages/medical/medical_page.dart';
import 'package:virus_corona_tracker/pages/news/news_page.dart';
import 'package:virus_corona_tracker/pages/statistics/statistics_page.dart';

import 'package:virus_corona_tracker/app_localizations.dart';
import 'Settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(AppLocalizations.of(context).translate('exitPopupTitle')),
            content: Text(
                AppLocalizations.of(context).translate('exitPopupContent')),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('no')),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('yes')),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: IndexedStack(
          index: currentTab,
          children: <Widget>[
            Consumer<StatsService>(
              builder: (context, statsService, _) {
                return StatisticsPage(
                  statsService: statsService,
                );
              },
            ),
            Settings(),
            Consumer2<NewsService, StatsService>(
              builder: (context, newsService, statsService, _) {
                return NewsPage(
                  newsService: newsService,
                  statsService: statsService,
                );
              },
            ),

            MedicalPage(),

            //   Settings(),
          ],
        ),
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.grey.withAlpha(80),
          selectedItemBackgroundColor: Colors.lightGreen,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: currentTab,
        onSelectTab: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: AppLocalizations.of(context).translate('menuHome'),
          ),
          FFNavigationBarItem(
            iconData: Icons.show_chart,
            label: AppLocalizations.of(context).translate('analytics'),
          ),
          FFNavigationBarItem(
            iconData: Icons.library_books,
            label: AppLocalizations.of(context).translate('news'),
          ),
          FFNavigationBarItem(
            iconData: Icons.healing,
            label: AppLocalizations.of(context).translate('medical'),
          ),

          /*FFNavigationBarItem(
            iconData: Icons.settings,
            label:  AppLocalizations.of(context).translate('menuSettings'),
          ),*/
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Settings settings;

  const AppDrawer({
    Key key,
    this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
