import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesData extends ChangeNotifier {
  Map<String, Data> data;
  int items;
  String key;
  List<String> keys;

  StatesData() {
    items = 0;
    data = Map();
    dummyData();
    genKeys();
    refresh();
  }

  void refresh() async {
    data.clear();
    await fetchData();
    genKeys();
    notifyListeners();
  }

  void dummyData() {
    data['Total'] = Data(0, 0, 0, 0);
    key = 'Total';
    items = 4;
  }

  Future<void> fetchData() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body['statewise'];
    states.forEach((element) {
      Map<String, dynamic> temp = element;
      data[element['state']] = Data.fromJson(temp);
    });
  }

  void genKeys() {
    keys = data.keys.toList();
  }

  void updateKey(String temp) {
    key = temp;
    notifyListeners();
  }
}

class Data {
  final int active;
  final int confirmed;
  final int deaths;
  final int recovered;

  Data(this.active, this.confirmed, this.deaths, this.recovered);

  Data.fromJson(Map<String, dynamic> json)
      : active = int.parse(json['active']),
        confirmed = int.parse(json['confirmed']),
        deaths = int.parse(json['deaths']),
        recovered = int.parse(json['recovered']);

  List<BubbleData> getData() {
    List<BubbleData> temp = List();
    temp.add(BubbleData("Active", active, Colors.amber));
    temp.add(BubbleData("Deaths", deaths, Colors.red));
    temp.add(BubbleData("Confirmed", confirmed, Colors.deepOrangeAccent));
    temp.add(BubbleData("Recovered", recovered, Colors.greenAccent));
    return temp;
  }
}

class BubbleData {
  final String title;
  final int num;
  final Color color;

  BubbleData(this.title, this.num, this.color);
}
