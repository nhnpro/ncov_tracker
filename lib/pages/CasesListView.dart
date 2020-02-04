import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../app_localizations.dart';
import 'DataByCountry.dart';
import 'DataController.dart';

class CasesListView extends StatefulWidget {
  @override
  _CasesListViewState createState() => _CasesListViewState();
}

class _CasesListViewState extends State<CasesListView> {
  List<DataByCountry> players;
  final numberFormatter = NumberFormat.decimalPattern();
  @override
  void initState() {
    players = new List<DataByCountry>.from(CurrentDataList);
    super.initState();
  }

  getRowsCountry() {
    final rows2 = new List.generate(
        players.length,
        (int index) => new DataRow(cells: [
              new DataCell(Container(
                  width: 100, //SET width
                  child: Text(players[index].name,
                      style: new TextStyle(color: Colors.black)))),

          new DataCell(Container(
              width: 40, //SET width
              child: Text(numberFormatter.format(players[index].cases),
                  style: new TextStyle(color: Colors.deepPurple)))),

          new DataCell(Container(
              width: 40, //SET width
              child: Text(numberFormatter.format(players[index].deaths),
                  style: new TextStyle(color: Colors.red)))),

          new DataCell(Container(
              width: 40, //SET width
              child: Text(numberFormatter.format(players[index].recovered),
                  style: new TextStyle(color: Colors.green)))),

            ]));
    return rows2;
  }

  bool isSortN = true;
  bool isSortD = true;
  bool isSortR = true;
  bool isSortC = true;

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: isSortC,
      columns: <DataColumn>[
        DataColumn(
          label: Container(
            width: 60,
            child: Text(AppLocalizations.of(context).translate('country')),
          ),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              if (isSortN) {
                players.sort((a, b) => b.name.compareTo(a.name));

                isSortN = false;
              } else {
                players.sort((a, b) => a.name.compareTo(b.name));

                isSortN = true;
              }
            });
          },
          tooltip: "Country Or Regions",
        ),
        DataColumn(
          label: Container(
            width: 50,
            child: Text(AppLocalizations.of(context).translate('cases')),
          ),
          numeric: true,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              if (isSortC) {
                players.sort((a, b) => b.cases.compareTo(a.cases));

                isSortC = false;
              } else {
                players.sort((a, b) => a.cases.compareTo(b.cases));

                isSortC = true;
              }
            });
          },
          tooltip: "All Confirmed Cases",
        ),
        DataColumn(
          label: Container(
            width: 50,
            child: Text(AppLocalizations.of(context).translate('deaths')),
          ),
          numeric: true,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              if (isSortD) {
                players.sort((a, b) => b.deaths.compareTo(a.deaths));

                isSortD = false;
              } else {
                players.sort((a, b) => a.deaths.compareTo(b.deaths));

                isSortD = true;
              }
            });
          },
          tooltip: "All Confirmed Deaths",
        ),
        DataColumn(
          label: Container(
            width: 50,
            child: Text(AppLocalizations.of(context).translate('recovered')),
          ),
          numeric: true,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              if (isSortR) {
                players.sort((a, b) => b.recovered.compareTo(a.recovered));

                isSortR = false;
              } else {
                players.sort((a, b) => a.recovered.compareTo(b.recovered));

                isSortR = true;
              }
            });
          },
          tooltip: "All Confirmed Recovered",
        ),
      ],
      rows: getRowsCountry());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            AppLocalizations.of(context).translate('allCases'),
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            Container(
              child: bodyData(),
            ),
          ],
        ),
      ),
    );
  }
}
