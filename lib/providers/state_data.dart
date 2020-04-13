/// Provider for data of a particular state.

import 'dart:convert';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:coronavirusstatus/models/table_col_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class StateData extends ChangeNotifier {
  final String state;
  List<DistrictData> districts;
  List<ColData> columns;
  final List<InfoData> data;
  int sortCol;
  bool sortType;

  StateData(this.state, this.data) {
    this.districts = List();
    _dummyData();
    columns = _createCols();
    sortCol = 1;
    sortType = false;
    refresh();
  }

  Future<void> refresh() async {
    districts = await _fetchData(this.state);
    sort();
  }

  void setSort(int index, bool type) {
    sortType = type;
    sortCol = index;
    notifyListeners();
  }

  void sort() {
    this.districts.sort((e1, e2) => e1.cmp(e2, sortCol, sortType));
    notifyListeners();
  }

  void _dummyData() {
    this.districts.add(DistrictData('Dummy', 0, 0));
  }

  static List<ColData> _createCols() {
    List<ColData> temp = List();
    temp.add(ColData("DISTRICT", false));
    temp.add(ColData(constants.Titles.abbrConfirmed, true));
    return temp;
  }

  static Future<List<DistrictData>> _fetchData(String state) async {
    var res = await http.get(constants.IndianTrackerEndpoints.state);
    List<dynamic> body = jsonDecode(res.body);
    Map<String, dynamic> item = body.firstWhere((element) {
      Map<String, dynamic> el = element;
      return (el['state'] == state);
    });
    List<dynamic> data = item[constants.IndianTrackerJsonTags.districtData];
    List<DistrictData> temp =
        data.map((e) => DistrictData.fromJson(e)).toList();
    return temp;
  }
}

class DistrictData {
  final String name;
  final int confirmed;
  final int delta;

  DistrictData(this.name, this.confirmed, this.delta);

  DistrictData.fromJson(Map<String, dynamic> json)
      : delta = json['delta']['confirmed'],
        name = json['district'],
        confirmed =
            json[constants.IndianTrackerJsonTags.stateDistrictConfirmed];

  List<Widget> genRow() {
    return [
      Text(
        this.name,
        style: TextStyle(color: Colors.white),
      ),
      genWidget(this.confirmed, this.delta, constants.DataColors.confirmed),
    ];
  }

  static Widget genWidget(int value, int delta, Color color) {
    if (delta == 0) {
      return Text(value.toString());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "+$delta",
          style: TextStyle(color: color),
        ),
        Text(value.toString()),
      ],
    );
  }

  int cmp(DistrictData d, int col, bool order) {
    int temp = 0;
    switch (col) {
      case 0:
        temp = this.name.compareTo(d.name);
        break;
      case 1:
        temp = this.confirmed.compareTo(d.confirmed);
        break;
    }

    return ((order) ? 1 : -1) * temp;
  }
}
