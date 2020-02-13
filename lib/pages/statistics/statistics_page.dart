import 'package:division/division.dart';
import 'package:virus_corona_tracker/app_localizations.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(style: userImageStyle, child: Icon(Icons.account_circle)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt('Rein Gundersen Bentdal', style: nameTextStyle),
            SizedBox(height: 5),
            Txt('Creative builder', style: nameDescriptionTextStyle)
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
          _buildUserStatsItem('846s', 'Collect'),
          _buildUserStatsItem('51', 'Attention'),
          _buildUserStatsItem('267', 'Track'),
          _buildUserStatsItem('39', 'Coupons'),
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(20)
      ..textColor(Colors.white);
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 5),
        Txt(text, style: nameDescriptionTextStyle),
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

  final ParentStyle userCardStyle = ParentStyle()
    ..height(175)
    ..padding(horizontal: 20.0, vertical: 10)
    ..alignment.center()
    ..background.hex('#3977FF')
    ..borderRadius(all: 20.0)
    ..elevation(10, color: hex('#3977FF'));

  final ParentStyle userImageStyle = ParentStyle()
    ..height(50)
    ..width(50)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);

  final TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.white)
    ..fontSize(18)
    ..fontWeight(FontWeight.w600);

  final TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.6))
    ..fontSize(12);
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

  final ParentStyle actionsItemIconStyle = ParentStyle()
    ..alignmentContent.center()
    ..width(50)
    ..height(50)
    ..margin(bottom: 5)
    ..borderRadius(all: 30)
    ..background.hex('#F6F5F8')
    ..ripple(true);

  final ParentStyle actionsItemStyle = ParentStyle()..margin(vertical: 20.0);

  final TxtStyle actionsItemTextStyle = TxtStyle()
    ..textColor(Colors.black.withOpacity(0.8))
    ..fontSize(12);
}

class SettingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsItem(Icons.location_on, hex('#8D7AEE'), 'Address',
            'Ensure your harvesting address'),
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
                    AppLocalizations.of(context).translate('appTitle'),
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
            body: Container(
                color:Colors.grey.withAlpha(50),
                child: Parent(
                  style: contentStyle(context),
                  child: Column(
                    children: <Widget>[
//                      Txt('User settings', style: titleStyle),
                      UserCard(),
                      ActionsRow(),
                      SettingList(),
                    ],
                  ),
                )))
        /*    body: WebViewWrapper(
          key: Key(globalEmbedWeb.title), initialUrl: globalEmbedWeb.url),
    )*/
        ;
  }
}
