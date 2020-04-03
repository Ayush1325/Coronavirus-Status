import 'dart:convert';

import 'package:coronavirusstatus/models/table_col_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesData extends ChangeNotifier {
  List<Data> data;
  List<ColData> columns;
  int sortCol;
  bool sortType;
  bool width;

  StatesData(Size size) {
    data = _dummyData();
    width = _calcWidth(size);
    columns = _createCols();
    sortCol = 1;
    sortType = false;
    refresh();
  }

  void refreshSize(Size size) {
    width = _calcWidth(size);
    columns = _createCols();
  }

  bool _calcWidth(Size size) {
    return (size.width > 700);
  }

  Future<void> refresh() async {
    data = await _fetchData();
    notifyListeners();
  }

  void setSort(int index, bool type) {
    sortType = type;
    sortCol = index;
    notifyListeners();
  }

  void sort() {
    this.data.sort((e1, e2) => e1.cmp(e2, sortCol, sortType, width));
    notifyListeners();
  }

  List<ColData> _createCols() {
    List<ColData> temp = List();
    temp.add(ColData("State/Ut", false));
    temp.add(ColData("CNFMD", true));
    if (width) {
      temp.add(ColData("ACTV", true));
      temp.add(ColData("RCVRD", true));
    }
    temp.add(ColData("DCSD", true));
    return temp;
  }

  List<Data> _dummyData() {
    List<Data> temp = List();
    temp.add(Data("Total", 0, 0, 0, 0, 0, 0, 0));
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
  final int active;
  final int recovered;
  final int deltaConfirmed;
  final int deltaDeaths;
  final int deltaRecovered;

  Data(this.state, this.confirmed, this.deaths, this.active, this.recovered,
      this.deltaConfirmed, this.deltaRecovered, this.deltaDeaths);

  Data.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        confirmed = int.parse(json['confirmed']),
        active = int.parse(json['active']),
        recovered = int.parse(json['recovered']),
        deaths = int.parse(json['deaths']),
        deltaConfirmed = int.parse(json['deltaconfirmed']),
        deltaRecovered = int.parse(json['deltarecovered']),
        deltaDeaths = int.parse(json['deltadeaths']);

  List<String> getRow(bool state) {
    List<String> temp = [this.state, this.confirmed.toString()];
    if (state) {
      temp.add(this.active.toString());
      temp.add(this.recovered.toString());
    }
    temp.add(this.deaths.toString());
    return temp;
  }

  List<dynamic> getStateData() {
    return [
      this.state,
      this.confirmed,
      this.active,
      this.recovered,
      this.deaths,
      this.deltaConfirmed,
      this.deltaRecovered,
      this.deltaDeaths,
    ];
  }

  int cmp(Data d, int col, bool order, bool width) {
    int temp = 0;
    if (width) {
      switch (col) {
        case 0:
          temp = this.state.compareTo(d.state);
          break;
        case 1:
          temp = this.confirmed.compareTo(d.confirmed);
          break;
        case 2:
          temp = this.active.compareTo(d.active);
          break;
        case 3:
          temp = this.recovered.compareTo(d.recovered);
          break;
        case 4:
          temp = this.deaths.compareTo(d.deaths);
          break;
      }
    } else {
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
    }
    return ((order) ? 1 : -1) * temp;
  }
}
