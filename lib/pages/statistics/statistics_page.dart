import 'package:virus_corona_tracker/app_localizations.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/pages/statistics/counter_page.dart';
import 'package:virus_corona_tracker/utils/helper.dart';
import 'package:virus_corona_tracker/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  final StatsService statsService;

  const StatisticsPage({
    Key key,
    this.statsService,
  }) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final List<EmbeddedWeb> _embededWebs = [
    EmbeddedWeb(
      title: 'Analytics',
      url: 'https://www.coronatracker.com/analytics',
    ),
  ];
  final EmbeddedWeb globalEmbedWeb = EmbeddedWeb(
    title: 'Analytics',
    url: 'https://www.coronatracker.com/analytics',
  );

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _embededWebs.length + 1);
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
              AppLocalizations.of(context).translate('analytics'),
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Bebas',
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            elevation: 2.0,
            backgroundColor: Colors.grey[50],
            pinned: true,
            forceElevated: true,
          ),
        ];
      },
      body: WebViewWrapper(
          key: Key(globalEmbedWeb.title), initialUrl: globalEmbedWeb.url),
    );
  }
}
