import 'dart:convert';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeneralData extends ChangeNotifier {
  List<InfoData> data;
  DateTime lastUpdated;
  String delta;

  GeneralData() {
    data = dummyData();
    lastUpdated = DateTime.now();
    _setUpdated();
    refresh();
  }

  Future<void> refresh() async {
    data = await fetchData();
    _setUpdated();
    notifyListeners();
  }

  List<InfoData> dummyData() {
    List<InfoData> temp = List();
    temp.add(InfoData('Confirmed', 0, 0, Colors.red));
    temp.add(InfoData("Active", 0, 0, Colors.blue));
    temp.add(InfoData("Recovered", 0, 0, Colors.green));
    temp.add(InfoData("Deceased", 0, 0, Colors.blueGrey[300]));
    return temp;
  }

  void _setUpdated() {
    Duration temp = DateTime.now().difference(lastUpdated);
    if (temp.inSeconds < 60) {
      delta = "${temp.inSeconds} Seconds";
    } else if (temp.inMinutes < 60) {
      delta = "${temp.inMinutes} Minutes";
    } else if (temp.inHours < 24) {
      delta = "${(temp.inHours + ((temp.inMinutes % 60) / 60)).ceil()} Hours";
    } else {
      delta = "${temp.inDays} Days";
    }
  }

  Future<List<InfoData>> fetchData() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body['statewise'];
    Map<String, dynamic> total = states.first;
    lastUpdated =
        DateFormat("dd/MM/yyyy HH:mm:ss").parse(total['lastupdatedtime']);
    List<InfoData> temp = List();
    temp.add(InfoData('Confirmed', int.parse(total['confirmed']),
        int.parse(total['deltaconfirmed']), Colors.red));
    temp.add(InfoData("Active", int.parse(total['active']), 0, Colors.blue));
    temp.add(InfoData("Recovered", int.parse(total['recovered']),
        int.parse(total['deltarecovered']), Colors.green));
    temp.add(InfoData("Deceased", int.parse(total['deaths']),
        int.parse(total['deltadeaths']), Colors.blueGrey[300]));
    return temp;
  }
}
