import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:virus_corona_tracker/core/api.dart';
import 'package:virus_corona_tracker/core/hospital.dart';
import 'package:virus_corona_tracker/core/news.dart';
import 'package:virus_corona_tracker/core/settings.dart';
import 'package:virus_corona_tracker/core/stat.dart';
import 'package:virus_corona_tracker/core/travel_alert.dart';
import 'package:virus_corona_tracker/pages/CasesListView.dart';

import 'app_localizations.dart';
import 'pages/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final remoteRepo = RemoteRepository();
  final settings = Settings();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Settings>.value(
            value: settings,
          ),
          ChangeNotifierProvider<NewsService>(
            create: (_) => NewsService(
              remote: remoteRepo,
              settings: settings,
            ),
          ),
          ChangeNotifierProvider<StatsService>(
            create: (_) => StatsService(
              remote: remoteRepo,
              settings: settings,
            ),
          ),
          ChangeNotifierProvider<HospitalsService>(
            create: (_) => HospitalsService(
              remote: remoteRepo,
              settings: settings,
            ),
          ),
          ChangeNotifierProvider<TravelAlertsService>(
            create: (_) => TravelAlertsService(
              remote: remoteRepo,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Covid19 Virus Tracker',
          supportedLocales: [
            Locale('en', ''),
            Locale('vi', ''),
          ],
          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // return supportedLocales.last;
            // Check if the current device locale is supported
            print("Current Locale:" + locale.toString());
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0XFF6D3FFF),
            accentColor: Color(0XFF233C63),
            fontFamily: 'Poppins',
          ),
          // home: Welcome(),

          // Start the app with the "/" named route. In this case, the app starts
          // on the FirstScreen widget.
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => Home(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/listViewRoute': (context) => CasesListView(),
          },
        ));
  }
}
