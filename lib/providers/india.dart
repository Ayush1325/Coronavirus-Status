import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class India extends ChangeNotifier {
  List<Data> homeData;

  India() {
    homeData = List();
    dummyData();
    refresh();
  }

  void refresh() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> temp = body['cases_time_series'];
    Map<String, dynamic> item = temp.last;
    homeData.clear();
    homeData.add(Data('Total', item['totalconfirmed'].toString(), Colors.blue));
    homeData.add(Data('Deaths', item['totaldeceased'].toString(), Colors.red));
    homeData.add(
        Data('Recovered', item['totalrecovered'].toString(), Colors.amber));
    notifyListeners();
  }

  void dummyData() {
    homeData.add(Data('Total', 0.toString(), Colors.blue));
    homeData.add(Data('Deaths', 0.toString(), Colors.red));
    homeData.add(Data('Recovered', 0.toString(), Colors.amber));
  }
}

class Data {
  final String title;
  final String value;
  final Color color;

  Data(this.title, this.value, this.color);
}
