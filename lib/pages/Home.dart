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
            Consumer2<NewsService, StatsService>(
              builder: (context, newsService, statsService, _) {
                return NewsPage(
                  newsService: newsService,
                  statsService: statsService,
                );
              },
            ),
            Consumer<StatsService>(
              builder: (context, statsService, _) {
                return StatisticsPage(
                  statsService: statsService,
                );
              },
            ),
            MedicalPage(),
            Settings(),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('menuHome'),
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.multiline_chart,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('analytics'),
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.healing,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('medical'),
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate('menuSettings'),
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
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
