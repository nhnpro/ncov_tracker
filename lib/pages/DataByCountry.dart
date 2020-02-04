class DataByCountry {
  DataByCountry(this.name, this.cases, this.deaths, this.recovered, this.lastUpdate);
  final String name;
  final int cases;
  final int deaths;
  final int recovered;
  final DateTime lastUpdate;
  bool selected =false;
}


class DataTip {
  DataTip(this.name, this.asset, this.type, this.address);
  final String name;
  final String asset;
  final String type;
  final String address;
}
