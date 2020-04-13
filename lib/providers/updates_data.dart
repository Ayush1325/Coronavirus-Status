import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class UpdatesData extends ChangeNotifier {
  List<Data> data;

  UpdatesData() {
    data = List();
    refresh();
  }

  Future<void> refresh() async {
    data = await _fetchData();
    notifyListeners();
  }

  Future<List<Data>> _fetchData() async {
    var res = await http.get(constants.IndianTrackerEndpoints.updates);
    List<dynamic> body = jsonDecode(res.body);
    return body
        .map((e) {
          Map<String, dynamic> temp = e;
          return Data.fromJson(temp);
        })
        .toList()
        .reversed
        .toList();
  }
}

class Data {
  final String value;
  final DateTime time;

  Data(this.value, this.time);

  Data.fromJson(Map<String, dynamic> data)
      : value = data['update'],
        time = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] * 1000);
}
