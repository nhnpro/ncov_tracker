import 'package:virus_corona_tracker/app_localizations.dart';
import 'package:virus_corona_tracker/core/hospital.dart';
import 'package:virus_corona_tracker/core/travel_alert.dart';
import 'package:virus_corona_tracker/pages/medical/hospital_page.dart';
import 'package:virus_corona_tracker/pages/medical/sources_page.dart';
import 'package:virus_corona_tracker/pages/medical/travel_alert_page.dart';
import 'package:virus_corona_tracker/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalPage extends StatefulWidget {
  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final List<EmbeddedWeb> _embededWebs = [
    EmbeddedWeb(
      title: 'whatthat',
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/about/index.html',
    ),
    EmbeddedWeb(
      title: 'prevention',
      url:
          'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _embededWebs.length + 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('medical'),
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Bebas',
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            bottom: TabBar(
              controller: _controller,
              isScrollable: true,
              indicatorWeight: 4.0,
              labelColor: Theme.of(context).accentColor,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Bebas',
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(text: AppLocalizations.of(context).translate('hospitals')),
                Tab(text:  AppLocalizations.of(context).translate('travelAlerts')),
                ..._embededWebs
                    .map(
                      (web) => Tab(
                        text:  AppLocalizations.of(context).translate(web.title),
                      ),
                    )
                    .toList(),
                Tab(text: 'Sources'),
              ],
            ),
            elevation: 2.0,
            backgroundColor: Colors.grey[50],
            pinned: true,
            forceElevated: true,
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Consumer<HospitalsService>(
            builder: (context, hospitalsService, _) => HospitalPage(
              hospitalsService: hospitalsService,
            ),
          ),
          Consumer<TravelAlertsService>(
            builder: (context, travelAlertsService, _) => TravelAlertPage(
              travelAlertsService: travelAlertsService,
            ),
          ),
          ..._embededWebs
              .map(
                (web) => WebViewWrapper(
                  key: Key(web.title),
                  initialUrl: web.url,
                ),
              )
              .toList(),
          SourcesPage(),
        ],
      ),
    );
  }
}
