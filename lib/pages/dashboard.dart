import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virus_corona_tracker/Country.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:virus_corona_tracker/pages/DataByCountry.dart';

import '../app_localizations.dart';
import 'DataController.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => RefreshIfNotHaveData(context));

    timer = Timer.periodic(Duration(seconds: 1800), (Timer t) => Refresh());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final numberFormatter = NumberFormat.decimalPattern();
  final dateFormatter = new DateFormat.yMMMd(currentAppLocale);
  final dateFormatter2 = new DateFormat.yMMMd(currentAppLocale).add_jm();

  List<Widget> buildStatCardList() {
    List<Widget> widgetList = [];

    for (var cc in CurrentDataList) {
      widgetList.add(new StatCard(
        title: cc.name,
        achieved: cc.deaths,
        total: totalConfirmedCase,
        achieved1: cc.cases,
        achieved2: cc.recovered,
        color: Colors.red,
        color2: Colors.green,
        image: Image.asset(Country.findByCountryName(cc.name).asset, width: 40),
      ));
    }
    return widgetList;
  }

  List<Widget> buildTipCardList() {
    List<Widget> widgetList = [];
    //"https://www.wikihow.com/Wear-an-N95-Face-Mask"
    //"assets/img/handwash.png"
    for (var cc in CurrentDataTip) {
      widgetList.add(new CupertinoButton(
        onPressed: () {
          _launchURLCustom(AppLocalizations.of(context).translate(cc.address));
        },
        child: Container(
          height: 180,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(cc.asset),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Text(
              AppLocalizations.of(context).translate(cc.name),
              style: TextStyle(
                  color: Colors.deepPurple, fontSize: 18, fontFamily: "Bebas"),
            ),
          ),
        ),
      ));
    }
    return widgetList;
  }

  _launchURLCustom(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  StateItem currentStateItem;
  Future<void> Refresh() async {
    if (progressDialog.isShowing()) return;
    progressDialog.style(
        message: AppLocalizations.of(context).translate("updating"));
    progressDialog.show();
    downloadncovsheet(() => setState(() {
          progressDialog.hide();
        }));
  }

  void RefreshIfNotHaveData(BuildContext context) {
    if (NumOfSuccessFetch <= 0) {
      Refresh();
    }
  }

  Widget buildAppBarFlexible(
      AsyncSnapshot<StateItem> currentStateItem, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*         Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                  child: Image.asset(
                    'assets/img/shoe.png',
                    width: 60,
                  ),
                ),*/
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '0 Steps'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '9000 Steps'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: 0.7,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor:
                            Theme.of(context).accentColor.withAlpha(30),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),*/
                  Text(
                    AppLocalizations.of(context)
                        .translate('totalCases')
                        .toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Bebas',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('lastUpdate') +
                        ": " +
                        dateFormatter2.format(GetLastUpdateDate()),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              numberFormatter.format(!currentStateItem.hasData
                  ? totalConfirmedCase
                  : currentStateItem.data?.num_confirm),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 80,
                fontFamily: 'Bebas',
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 25,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('deaths'),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: numberFormatter.format(
                                    !currentStateItem.hasData
                                        ? totalDeathCase
                                        : currentStateItem.data.num_dead),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              /*  TextSpan(
                                    text: ' m',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('recovered'),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: numberFormatter.format(
                                    !currentStateItem.hasData
                                        ? totalRecoveredCase
                                        : currentStateItem.data.num_heal),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              /* TextSpan(
                                    text: ' cal',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('country'),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: GetTotalCountry().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              /* TextSpan(
                                    text: ' bpm',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('countryRegions'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 22,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          showListViewAll();
                        },
                        color: Theme.of(context).accentColor,
                        child: Text(
                          AppLocalizations.of(context).translate("viewAll"),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ]),
              ],
            ),
            Container(
              height: 230,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: buildStatCardList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('tipHeader'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 22,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => {
                          _launchURLCustom(AppLocalizations.of(context)
                              .translate('viewMoreURL'))
                        },
                        color: Theme.of(context).accentColor,
                        child: Text(
                          AppLocalizations.of(context).translate("viewAll"),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ]),
              ],
            ),
            Container(
              height: 200,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: buildTipCardList()),
            ),
          ],
        ),
      ),
    );
  }

  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/img/icon.png',
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('homeTitle'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  dateFormatter.format(new DateTime.now()),
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: Refresh,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: 50,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.blueAccent,
                    size: 35,
                  ),
                ),
                /*  Positioned(
                  top: 0,
                  right: 0,
                  width: 20,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red,
                    ),
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        'f5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          )
        ],
      ),
      body: FutureBuilder<StateItem>(
          future: fetchStat(Client()),
          builder: (BuildContext context, AsyncSnapshot<StateItem> snapshot) {
            return SingleChildScrollView(
                child: buildAppBarFlexible(snapshot, context));
          }),
    );
  }

  void showListViewAll() {
    Navigator.of(context).pushNamed("/listViewRoute");
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final int total;
  final int achieved;
  final int achieved2;
  final int achieved1;
  final Image image;
  final Color color;
  final Color color2;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
    @required this.achieved2,
    @required this.color2,
    @required this.achieved1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).accentColor.withAlpha(200),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved1 / (total < achieved1 ? achieved1 : total),
            circularStrokeCap: CircularStrokeCap.butt,
            center: image,
            header: Text(
              AppLocalizations.of(context).translate('cases') +
                  ": " +
                  NumberFormat.decimalPattern().format(achieved1),
              style: TextStyle(fontSize: 16),
            ),
            progressColor: color,
            backgroundColor: Theme.of(context).accentColor.withAlpha(30),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              /* TextSpan(
                text: AppLocalizations.of(context).translate('cases') +
                    ": " +
                    NumberFormat.decimalPattern().format(achieved1),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),*/
              TextSpan(
                text: "\n" +
                    AppLocalizations.of(context).translate('deaths') +
                    ": " +
                    NumberFormat.decimalPattern().format(achieved),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: "\n" +
                    AppLocalizations.of(context).translate('recovered') +
                    ": " +
                    NumberFormat.decimalPattern().format(achieved2),
                style: TextStyle(
                  color: color2,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                  fontSize: 13,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
