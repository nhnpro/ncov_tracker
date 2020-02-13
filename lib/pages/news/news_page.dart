import 'dart:async';

import 'package:ant_icons/ant_icons.dart';
import 'package:intl/intl.dart';
import 'package:virus_corona_tracker/app_localizations.dart';
import 'package:virus_corona_tracker/core/news.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/model/model.dart';
import 'package:virus_corona_tracker/pages/news/news_detail_page.dart';
import 'package:virus_corona_tracker/pages/statistics/counter_page.dart';
import 'package:virus_corona_tracker/utils/helper.dart';
import 'package:virus_corona_tracker/widgets/counter.dart';
import 'package:virus_corona_tracker/widgets/items/news_snippet.dart';
import 'package:virus_corona_tracker/widgets/search_delegate.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final NewsService newsService;
  final StatsService statsService;

  const NewsPage({
    Key key,
    this.newsService,
    this.statsService,
  }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ScrollController newsFeedController;
  ScrollController appBarController;
  bool _isScrolled = false;



  @override
  bool get wantKeepAlive => true;

  loadStats() {
    widget.statsService.getStats();
  }




  @override
  void initState() {
    super.initState();
    widget.statsService.addListener(() {
      setState(() {});
    });

    loadStats();
    appBarController = ScrollController();
    newsFeedController = ScrollController()
      ..addListener(() {
        setState(() {
          _isScrolled = newsFeedController.offset != 0;
        });

        appBarController.jumpTo(newsFeedController.offset);
        if (newsFeedController.offset >=
                newsFeedController.position.maxScrollExtent &&
            !newsFeedController.position.outOfRange) {
          setState(() {
            widget.newsService.page++;
            widget.newsService.fetch();
          });
        }
      });

    widget.newsService.addListener(() {
      setState(() {});
    });

    widget.newsService.fetch();
  }

  @override
  void dispose() {
    newsFeedController.dispose();
    super.dispose();
  }


  Future<void> handleRefresh() async {
    setState(() {
      loadStats();
      widget.newsService.refresh();
    });
    return;
  }

  onTap(int nid) {
    News selectedNews =
        widget.newsService.news.firstWhere((news) => news.nid == nid);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          news: selectedNews,
        ),
      ),
    );
  }

  _backtoTop() => newsFeedController.jumpTo(0.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NestedScrollView(
          controller: appBarController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                floating: false,
                expandedHeight: 220,
                forceElevated: true,

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(220.0),
                  child: Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width*1,
                    alignment: Alignment(0.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withAlpha(80),
                   /*   border: Border.all(
                        color: Colors.black.withAlpha(50),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),*/
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CounterWrapper(
                            title: AppLocalizations.of(context).translate('allCases'),
                            color: Color(0xFFB03060),
                            number: widget.statsService.stats?.numConfirm ?? 0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MiniCounterWrapper(
                                  title: AppLocalizations.of(context).translate('deaths'),
                                  color: Colors.grey[700],
                                  number:
                                      widget.statsService.stats?.numDead ?? 0,
                                ),
                                Padding(padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0,
                                )),
                                MiniCounterWrapper(
                                  title: AppLocalizations.of(context).translate('Recovered'),
                                  color: Color(0xFF5DBD4A),
                                  number:
                                      widget.statsService.stats?.numHeal ?? 0,
                                ),
                              ]),
                        ]),
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context).translate('appTitle'),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Bebas',
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    AntIcons.search_outline,
                    color: Colors.black.withOpacity(0.75),
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NewsSearchDelegate(),
                    );
                  },
                ),
             /*   actions: <Widget>[
                  IconButton(
                    icon: Helper.getFlagIcon(
                      countryCode: widget.newsService.countryCode ?? 'GLOBAL',
                      width: 24.0,
                      height: null,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],*/
                elevation: 4.0,
                backgroundColor: Colors.grey[50],

              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: handleRefresh,
            child: NewsFeed(
              key: PageStorageKey('newsFeed'),
              news: widget.newsService.news,
              controller: newsFeedController,
              onTap: onTap,
              state: widget.newsService.state,
            ),
          ),
        ),
        //   CounterPage(statsService: widget.statsService),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translate(
                  0.0,
                  _isScrolled ? 0.0 : 120.0,
                  0.0,
                ),
              child: FloatingActionButton(
                onPressed: _backtoTop,
                elevation: 4.0,
                child: Icon(
                  Icons.keyboard_arrow_up,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsFeed extends StatelessWidget {
  final List<News> news;
  final Function(int) onTap;
  final ScrollController controller;
  final NewsFeedState state;

  NewsFeed({
    Key key,
    this.news,
    this.onTap,
    this.controller,
    this.state,
  }) : super(key: key);

  bool get isLoading => state == NewsFeedState.loading;

  @override
  Widget build(BuildContext context) {
    if (news.length == 0) {
      return Center(
        child: Text(AppLocalizations.of(context).translate('noresult')),
      );
    }

    return ListView.separated(
      itemCount: isLoading ? news.length + 1 : news.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      separatorBuilder: (context, index) {
        if (isLoading && index == news.length) {
          return Container();
        }

        return SizedBox(
          height: 12.0,
          child: Container(color: Colors.grey[200]),
        );
      },
      itemBuilder: (context, index) {
        if (isLoading && index == news.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return NewsSnippet(
          nid: news[index].nid,
          title: news[index].title,
          timestamp: news[index].publishedAt ?? '',
          url: news[index].url,
          imgUrl: news[index].urlToImage ?? '',
          onTap: onTap,
        );
      },
    );
  }
}

class MiniCounterWrapper extends StatelessWidget {
  final String title;
  final Color color;
  final int number;

  const MiniCounterWrapper({
    Key key,
    this.title,
    this.color = Colors.blue,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          AnimatedCounter(
            color: color,
            number: number,
            fontSize: 27,
          ),
        ],
      ),
    );
  }
}
