import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesData extends ChangeNotifier {
  List<Data> data;
  List<ColData> columns;
  int sortCol;
  bool sortType;

  StatesData() {
    data = _dummyData();
    columns = _createCols();
    sortCol = 1;
    sortType = false;
    refresh();
  }

  void refresh() async {
    data = await _fetchData();
    notifyListeners();
  }

  void setSort(int index, bool type) {
    sortType = type;
    sortCol = index;
    notifyListeners();
  }

  void sort() {
    this.data.sort((e1, e2) => e1.cmp(e2, sortCol, sortType));
    notifyListeners();
  }

  List<ColData> _createCols() {
    List<ColData> temp = List();
    temp.add(ColData("State/Ut", false));
    temp.add(ColData("CNFMD", true));
    temp.add(ColData("DCSD", true));
    return temp;
  }

  List<Data> _dummyData() {
    List<Data> temp = List();
    temp.add(Data("Total", 0, 0));
    return temp;
  }

  Future<List<Data>> _fetchData() async {
    List<Data> temp = List();
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body['statewise'];
    states.forEach((element) {
      Map<String, dynamic> t = element;
      temp.add(Data.fromJson(t));
    });
    temp.removeAt(0);
    return temp;
  }
}

class Data {
  final String state;
  final int confirmed;
  final int deaths;

  Data(this.state, this.confirmed, this.deaths);

  Data.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        confirmed = int.parse(json['confirmed']),
        deaths = int.parse(json['deaths']);

  List<String> getList() {
    return [this.state, this.confirmed.toString(), this.deaths.toString()];
  }

  int cmp(Data d, int col, bool order) {
    int temp = 0;
    switch (col) {
      case 0:
        temp = this.state.compareTo(d.state);
        break;
      case 1:
        temp = this.confirmed.compareTo(d.confirmed);
        break;
      case 2:
        temp = this.deaths.compareTo(d.deaths);
        break;
    }
    return ((order) ? 1 : -1) * temp;
  }
}

class ColData {
  final String title;
  final bool isNumeric;

  ColData(this.title, this.isNumeric);
}
