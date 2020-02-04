import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'DataByCountry.dart';

String currentAppLocale = "en";
DateTime lastUpdateTime;

bool IsInAyncCall = false;

int totalCountry = 0;
int totalConfirmedCase = 0;
int totalDeathCase = 0;
int totalRecoveredCase = 0;

int oldConfirmedCase = 0;
int oldDeathCase = 0;
int oldRecoveredCase = 0;
int NumOfSuccessFetch = 0;

List<List<dynamic>> CurrentCsvData;
List<DataByCountry> CurrentDataList = <DataByCountry>[];
final List<DataTip> CurrentDataTip = <DataTip>[
  new DataTip("faceMask", "assets/img/face_mask.png", "web", "faceMaskURL"),
  new DataTip("handWash", "assets/img/handwash.png", "web", "handWashURL"),
  new DataTip("hydrated", "assets/img/drinkwater.png", "web", "hydratedURL"),
  new DataTip("exercise", "assets/img/exercise.png", "web", "exerciseURL"),
  new DataTip(
      "doctorCheck", "assets/img/doctorcheck.png", "web", "doctorCheckURL"),
];

int GetTotalCountry() {
  return totalCountry;
}

DateTime GetLastUpdateDate() {
  if (lastUpdateTime == null) return DateTime.now();
  return lastUpdateTime;
}

final String googleSheetURL =
    "https://docs.google.com/spreadsheets/d/1wQVypefm946ch4XDp37uZ-wartW4V7ILdg-qYiDXUHM/export?format=csv";
final String confirmedTimeSeriesURL =
    "https://docs.google.com/spreadsheets/d/1UF2pSkFTURko2OvfHWWlFpDFAr1UxCBA4JLwlSP6KFo/gviz/tq?tqx=out:csv&sheet=confirmed";
final String recoveredTimeSeriesURL =
    "https://docs.google.com/spreadsheets/d/1UF2pSkFTURko2OvfHWWlFpDFAr1UxCBA4JLwlSP6KFo/gviz/tq?tqx=out:csv&sheet=recovered";
final String deathTimeSeriesURL =
    "https://docs.google.com/spreadsheets/d/1UF2pSkFTURko2OvfHWWlFpDFAr1UxCBA4JLwlSP6KFo/gviz/tq?tqx=out:csv&sheet=death";
void downloadncovsheet(VoidCallback onComplete) {
  downloadCSV(googleSheetURL, onComplete);
}

void downloadCSV(url, VoidCallback onComplete) {
  IsInAyncCall = true;
  HttpClient client = new HttpClient();
  var _downloadData = StringBuffer();

  client.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.transform(utf8.decoder).listen((d) => _downloadData.write(d),
        onDone: () {
      var str = _downloadData.toString();
      List<List<dynamic>> dat = const CsvToListConverter().convert(str);

      if (dat != null && dat.length > 1) {
        CurrentCsvData = dat;
        print("Total Rows:" + CurrentCsvData.length.toString());
        ProccessData();
        onComplete();
      }
      NumOfSuccessFetch++;
      IsInAyncCall = false;
    }, onError: (err) {
      IsInAyncCall = false;
      onComplete();
    });
  });
}

void ProccessData() {
  if (CurrentCsvData != null && CurrentCsvData.length > 1) {
    var countryColumn = 0;
    var confirmedCaseColumn = 0;
    var deathCaseColumn = 0;
    var recoveryCaseColumn = 0;
    var lastUpdateColumn = 0;

    List<String> countries = [];
    var caseByCountries = {
      'countries': 0,
    };

    var deathByCountries = {
      'countries': 0,
    };

    var recoveredByCountries = {
      'countries': 0,
    };

    var dateByCountries = {
      'countries': DateTime.now(),
    };

    for (var i = 0; i < CurrentCsvData[0].length; i++) {
      print(i.toString() + "=>" + CurrentCsvData[0][i]);
      if (CurrentCsvData[0][i].contains("Confirmed")) {
        confirmedCaseColumn = i;
      } else if (CurrentCsvData[0][i].contains("Deaths")) {
        deathCaseColumn = i;
      } else if (CurrentCsvData[0][i].contains("Recovered")) {
        recoveryCaseColumn = i;
      } else if (CurrentCsvData[0][i].contains("Update")) {
        lastUpdateColumn = i;
      } else if (CurrentCsvData[0][i].contains("Country")) {
        countryColumn = i;
      }
    }

    var kkk = 0;
    for (var i = 1; i < CurrentCsvData.length; i++) {
      var xxx = new DateFormat("MM/d/yyyy HH:mm")
          .parse(CurrentCsvData[i][lastUpdateColumn])
          .millisecondsSinceEpoch;
      if (xxx > kkk) {
        kkk = xxx;
        lastUpdateTime = new DateFormat("MM/d/yyyy HH:mm")
            .parse(CurrentCsvData[i][lastUpdateColumn]);
      }
    }

    caseByCountries.clear();
    deathByCountries.clear();
    recoveredByCountries.clear();
    dateByCountries.clear();
    countries.clear();

    for (var i = 1; i < CurrentCsvData.length; i++) {
      var countryName = CurrentCsvData[i][countryColumn];
      if (!countries.contains(countryName)) countries.add(countryName);

      if (caseByCountries.containsKey(countryName)) {
        caseByCountries[countryName] += CurrentCsvData[i][confirmedCaseColumn];
      } else {
        caseByCountries[countryName] = CurrentCsvData[i][confirmedCaseColumn];
      }

      if (deathByCountries.containsKey(countryName)) {
        deathByCountries[countryName] += CurrentCsvData[i][deathCaseColumn];
      } else {
        deathByCountries[countryName] = CurrentCsvData[i][deathCaseColumn];
      }

      if (recoveredByCountries.containsKey(countryName)) {
        recoveredByCountries[countryName] +=
            CurrentCsvData[i][recoveryCaseColumn];
      } else {
        recoveredByCountries[countryName] =
            CurrentCsvData[i][recoveryCaseColumn];
      }

      if (dateByCountries.containsKey(countryName)) {
        var kkk = dateByCountries[countryName].millisecondsSinceEpoch;
        var xxx = new DateFormat("MM/d/yyyy HH:mm")
            .parse(CurrentCsvData[i][lastUpdateColumn])
            .millisecondsSinceEpoch;
        if (xxx > kkk) {
          dateByCountries[countryName] = new DateFormat("MM/d/yyyy HH:mm")
              .parse(CurrentCsvData[i][lastUpdateColumn]);
        }
      } else {
        dateByCountries[countryName] = new DateFormat("MM/d/yyyy HH:mm")
            .parse(CurrentCsvData[i][lastUpdateColumn]);
      }
    }
    totalCountry = caseByCountries.length;

    CurrentDataList.clear();
    for (var countryName in countries) {
      CurrentDataList.add(new DataByCountry(
          countryName,
          caseByCountries[countryName],
          deathByCountries[countryName],
          recoveredByCountries[countryName],
          dateByCountries[countryName]));
    }
    var totalC = 0;
    for (var i = 1; i < CurrentCsvData.length; i++) {
      totalC += CurrentCsvData[i][confirmedCaseColumn];
    }

    if (totalConfirmedCase > 0) oldConfirmedCase = totalConfirmedCase;
    totalConfirmedCase = totalC;

    var totalD = 0;
    for (var i = 1; i < CurrentCsvData.length; i++) {
      totalD += CurrentCsvData[i][deathCaseColumn];
    }

    if (totalDeathCase > 0) oldDeathCase = totalDeathCase;
    totalDeathCase = totalD;

    var totalR = 0;
    for (var i = 1; i < CurrentCsvData.length; i++) {
      totalR += CurrentCsvData[i][recoveryCaseColumn];
    }

    if (totalRecoveredCase > 0) oldRecoveredCase = totalRecoveredCase;
    totalRecoveredCase = totalR;
  }
}

int convertFromString(str) {
  if (str != "" && str != null && str.length > 0) {
    var x = int.tryParse(str);
    if (x != null) return x;
  }
  return 0;
}
