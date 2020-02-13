import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import '../app_localizations.dart';
import 'DataController.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _launchURL() async {
    const url =
        "https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        title: Text(
          AppLocalizations.of(context).translate('menuSettings'),
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Bebas',
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 20, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/img/illustration.png',
                  width: 300,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  AppLocalizations.of(context).translate('welcomeString'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('appTitle')
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('appDesc'), //+"\n Sheet:" + googleSheetURL,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                MaterialButton(
                  onPressed: _launchURL,
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    AppLocalizations.of(context).translate('viewWeb'),
                    style: TextStyle(fontSize: 23),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: MaterialButton(
                    onPressed: () {
                      LaunchReview.launch();
                    },
                    minWidth: double.infinity,
                    height: 40,
                    color: Theme.of(context).secondaryHeaderColor,
                    textColor: Theme.of(context).accentColor,
                    child: Text(
                      AppLocalizations.of(context).translate('rateMe'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
