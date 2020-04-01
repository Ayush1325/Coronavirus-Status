import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeneralData extends ChangeNotifier {
  List<Data> data;
  GeneralData() {
    data = dummyData();
    refresh();
  }

  void refresh() async {
    data = await fetchData();
    notifyListeners();
  }

  List<Data> dummyData() {
    List<Data> temp = List();
    temp.add(Data('Confirmed', 0, 0, Colors.red));
    temp.add(Data("Active", 0, 0, Colors.blue));
    temp.add(Data("Recovered", 0, 0, Colors.green));
    temp.add(Data("Deceased", 0, 0, Colors.blueGrey));
    return temp;
  }

  Future<List<Data>> fetchData() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body['statewise'];
    List<dynamic> keyValues = body['key_values'];
    Map<String, dynamic> total = states.first;
    Map<String, dynamic> deltas = keyValues.first;
    List<Data> temp = List();
    temp.add(Data('Confirmed', int.parse(total['confirmed']),
        int.parse(deltas['confirmeddelta']), Colors.red));
    temp.add(Data("Active", int.parse(total['active']), 0, Colors.blue));
    temp.add(Data("Recovered", int.parse(total['recovered']),
        int.parse(deltas['recovereddelta']), Colors.green));
    temp.add(Data("Deceased", int.parse(total['deaths']),
        int.parse(deltas['deceaseddelta']), Colors.blueGrey));
    return temp;
  }
}

class Data {
  final String title;
  final int num;
  final int delta;
  final Color color;

  Data(this.title, this.num, this.delta, this.color);
}
