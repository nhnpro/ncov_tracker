class DataByCountry {
  DataByCountry(
      this.name, this.cases, this.deaths, this.recovered, this.lastUpdate);
  final String name;
  final int cases;
  final int deaths;
  final int recovered;
  final DateTime lastUpdate;
  bool selected = false;
}

class DataTip {
  DataTip(this.name, this.asset, this.type, this.address);
  final String name;
  final String asset;
  final String type;
  final String address;
}

class StateItem {
  final int num_confirm;
  final int num_dead;
  final int num_heal;

  StateItem({this.num_confirm, this.num_dead, this.num_heal});

  factory StateItem.fromJson(Map<String, dynamic> json) {
    return StateItem(
      num_confirm: json['num_confirm'] as int,
      num_dead: json['num_dead'] as int,
      num_heal: json['num_heal'] as int,
    );
  }
}
