import 'package:ant_icons/ant_icons.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:virus_corona_tracker/app_localizations.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/pages/news/news_page.dart';
import 'package:virus_corona_tracker/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final StatsService statsService;
  final BuildContext context;

  UserCard({Key key, this.statsService, this.context}) : super(key: key);

  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(
            style: userImageStyle,
            child: Icon(
              AntIcons.global,
              color: Colors.white,
              size: 28,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(AppLocalizations.of(context).translate('totalCases'),
                style: nameTextStyle),
            Txt("  " +DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: nameDescriptionTextStyle)
          ],
        )
      ],
    );
  }

  Widget _buildUserStats() {
    return Parent(
      style: userStatsStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MiniCounterWrapper(
            color: Colors.blueGrey,
            textColor: Colors.white,
            title: AppLocalizations.of(context).translate('cases'),
            number: statsService?.stats?.numConfirm ?? 0,
          ),
          MiniCounterWrapper(
            color: Colors.red,
            title: AppLocalizations.of(context).translate('deaths'),
            number: statsService?.stats?.numDead ?? 0,
            textColor: Colors.black,
          ),
          MiniCounterWrapper(
            color: Colors.green,
            textColor: Colors.yellowAccent,
            title: AppLocalizations.of(context).translate('recovered'),
            number: statsService?.stats?.numHeal ?? 0,
          ),
//          _buildUserStatsItem('39', 'Coupons'),
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(20)
      ..textColor(Colors.white);

    final TxtStyle descriptionTextStyle = TxtStyle()
      ..textColor(Colors.white.withOpacity(0.7))
      ..fontSize(14);

    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 5),
        Txt(text, style: descriptionTextStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_buildUserRow(), _buildUserStats()],
      ),
    );
  }

  //Styling

  ParentStyle userCardStyle = ParentStyle()
    ..height(170)
    ..padding(horizontal: 10.0, vertical: 10)
    ..alignment.center()
    ..background.image(path: "assets/banner.png", fit: BoxFit.fill)
    //.color(Colors.blueAccent)
    ..borderRadius(all: 15.0)
    ..elevation(5, color: Colors.black45);

  ParentStyle userImageStyle = ParentStyle()
    ..height(40)
    ..width(40)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.color(Colors.blueGrey);

  ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);

  TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.brown)
    ..fontSize(20)
    ..fontFamily('Poppins')
    ..fontWeight(FontWeight.w600);

  TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.deepPurple)
    ..fontFamily('Bebas')
    ..fontSize(13);
}

class ActionsRow extends StatelessWidget {
  Widget _buildActionsItem(String title, IconData icon) {
    return Parent(
      style: actionsItemStyle,
      child: Column(
        children: <Widget>[
          Parent(
            style: actionsItemIconStyle,
            child: Icon(icon, size: 20, color: Color(0xFF42526F)),
          ),
          Txt(title, style: actionsItemTextStyle)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildActionsItem('Hospitals', Icons.healing),
        _buildActionsItem('Alert', Icons.card_travel),
        _buildActionsItem('Covid19', Icons.help_outline),
        _buildActionsItem('Prevention', Icons.block),
      ],
    );
  }

  ParentStyle actionsItemIconStyle = ParentStyle()
    ..alignmentContent.center()
    ..width(50)
    ..height(50)
    ..margin(bottom: 5)
    ..borderRadius(all: 30)
    ..background.hex('#F6F5F8')
    ..ripple(true);

  ParentStyle actionsItemStyle = ParentStyle()..margin(vertical: 20.0);

  TxtStyle actionsItemTextStyle = TxtStyle()
    ..textColor(Colors.black.withOpacity(0.8))
    ..fontSize(12);
}

class SettingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsItem(Icons.location_on, hex('#8D7AEE'), 'Your Country',
            'Cases: 1000000    Deaths: 8888828    Recovered: 2321312'),
        SettingsItem(
            Icons.lock, hex('#F468B7'), 'Privacy', 'System permission change'),
        SettingsItem(
            Icons.menu, hex('#FEC85C'), 'General', 'Basic functional settings'),
        SettingsItem(Icons.notifications, hex('#5FD0D3'), 'Notifications',
            'Take over the news in time'),
        SettingsItem(Icons.question_answer, hex('#BFACAA'), 'Support',
            'We are here to help'),
        SettingsItem(Icons.question_answer, hex('#BFACAA'), 'Support',
            'We are here to help'),
        SettingsItem(Icons.question_answer, hex('#BFACAA'), 'Support',
            'We are here to help'),
        SettingsItem(Icons.question_answer, hex('#BFACAA'), 'Support',
            'We are here to help'),
        SettingsItem(Icons.question_answer, hex('#BFACAA'), 'Support',
            'We are here to help'),
      ],
    );
  }
}

class SettingsItem extends StatefulWidget {
  SettingsItem(this.icon, this.iconBgColor, this.title, this.description);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: settingsItemStyle(pressed),
      gesture: Gestures()
        ..isTap((isTapped) => setState(() => pressed = isTapped)),
      child: Row(
        children: <Widget>[
          Parent(
            style: settingsItemIconStyle(widget.iconBgColor),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(widget.title, style: itemTitleTextStyle),
              SizedBox(height: 5),
              Txt(widget.description, style: itemDescriptionTextStyle),
            ],
          )
        ],
      ),
    );
  }

  final settingsItemStyle = (pressed) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.95 : 1.0)
    ..alignmentContent.center()
    ..height(70)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeOut);

  final settingsItemIconStyle = (Color color) => ParentStyle()
    ..background.color(color)
    ..margin(left: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  final TxtStyle itemTitleTextStyle = TxtStyle()
    ..bold()
    ..fontSize(16);

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12);
}

class MiniCaseCard extends StatefulWidget {
  MiniCaseCard(this.icon, this.iconBgColor, this.title, this.description);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _MiniCaseCardState createState() => _MiniCaseCardState();
}

class _MiniCaseCardState extends State<MiniCaseCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: highTagStyle2(pressed),
      gesture: Gestures()
        ..isTap((isTapped) => setState(() => pressed = isTapped)),
      child: Row(
        children: <Widget>[
          Parent(
            style: settingsItemIconStyle(widget.iconBgColor),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(widget.title, style: itemTitleTextStyle),
              SizedBox(height: 5),
              Txt(widget.description, style: itemDescriptionTextStyle),
            ],
          )
        ],
      ),
    );
  }

  final highTagStyle2 = (pressed) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.95 : 1.0)
    ..alignmentContent.topCenter()
    ..height(100)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeOut);

  final settingsItemIconStyle = (Color color) => ParentStyle()
    ..background.color(color)
    ..margin(left: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  final TxtStyle itemTitleTextStyle = TxtStyle()
    ..bold()
    ..fontSize(16);

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12);
}

class ChartViewCard extends StatefulWidget {
  ChartViewCard(this.icon, this.iconBgColor, this.title, this.description);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _ChartViewCardState createState() => _ChartViewCardState();
}

class _ChartViewCardState extends State<ChartViewCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: highTagStyle2(pressed),
      gesture: Gestures()
        ..isTap((isTapped) => setState(() => pressed = isTapped)),
      child: Row(
        children: <Widget>[
          Parent(
            style: settingsItemIconStyle(widget.iconBgColor),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(widget.title, style: itemTitleTextStyle),
              SizedBox(height: 5),
              Txt(widget.description, style: itemDescriptionTextStyle),
            ],
          )
        ],
      ),
    );
  }

  final highTagStyle2 = (pressed) => ParentStyle()
    ..elevation(pressed ? 0 : 50, color: Colors.grey)
    ..scale(pressed ? 0.95 : 1.0)
    ..alignmentContent.topCenter()
    ..height(300)
    ..margin(vertical: 10)
    ..borderRadius(all: 15)
    ..background.hex('#ffffff')
    ..ripple(true)
    ..animate(150, Curves.easeOut);

  final settingsItemIconStyle = (Color color) => ParentStyle()
    ..background.color(color)
    ..margin(left: 15)
    ..padding(all: 12)
    ..borderRadius(all: 30);

  final TxtStyle itemTitleTextStyle = TxtStyle()
    ..bold()
    ..fontSize(16);

  final TxtStyle itemDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.black26)
    ..bold()
    ..fontSize(12);
}

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
  final contentStyle = (BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(32)
    ..margin(bottom: 20)
    ..alignmentContent.centerLeft();

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
    widget.statsService.addListener(() {
      setState(() {});
    });

    loadStats();
    _controller = TabController(vsync: this, length: _embededWebs.length + 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  loadStats() {
    widget.statsService.getStats();
  }

  Future<void> handleRefresh() async {
    setState(() {
      loadStats();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context).translate('appTitle'),
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Bebas',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  elevation: 2.0,
                  backgroundColor: Colors.blue,
                  pinned: false,
                  forceElevated: false,
               /*   leading: IconButton(
                    icon: Icon(
                      AntIcons.setting,
                      color: Colors.black.withOpacity(0.75),
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                      );
                    },
                  ),*/
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        AntIcons.share_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),

                    IconButton(
                      icon: Icon(
                        AntIcons.setting,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ],
                ),
              ];
            },
            body: RefreshIndicator(
                onRefresh: handleRefresh,
                child: Container(
                    color: Colors.grey.withAlpha(70),
                    child: Parent(
                      style: contentStyle(context),
                      child: Column(
                        children: <Widget>[
//                      Txt('User settings', style: titleStyle),
                          UserCard(
                            statsService: widget.statsService,
                            context: context,
                          ),
                          ActionsRow(),
                          MiniCaseCard(
                              Icons.location_on,
                              hex('#8D7AEE'),
                              'Your Country',
                              'Cases: 1000000    Deaths: 8888828'),
                          ChartViewCard(
                              Icons.location_on,
                              hex('#8D7AEE'),
                              'Your Country',
                              'Cases: 1000000    Deaths: 8888828'),
                          ChartViewCard(
                              Icons.location_on,
                              hex('#8D7AEE'),
                              'Your Country',
                              'Cases: 1000000    Deaths: 8888828'),
                          SettingList(),
                        ],
                      ),
                    ))))
        /*    body: WebViewWrapper(
          key: Key(globalEmbedWeb.title), initialUrl: globalEmbedWeb.url),
    )*/
        ;
  }
}
