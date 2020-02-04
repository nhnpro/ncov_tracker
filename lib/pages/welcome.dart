import 'package:virus_corona_tracker/pages/DataController.dart';
import 'package:virus_corona_tracker/pages/Home.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';
import 'dashboard.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
  //  downloadncovsheet();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
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
                  AppLocalizations.of(context).translate('appTitle').toUpperCase(),
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  AppLocalizations.of(context).translate('appDesc'),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    AppLocalizations.of(context).translate('getStarted'),
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
               /* Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Change Language'.toUpperCase(),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
