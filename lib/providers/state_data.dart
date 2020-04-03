import 'dart:convert';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:coronavirusstatus/models/table_col_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StateData extends ChangeNotifier {
  final String state;
  List<DistrictData> districts;
  List<ColData> columns;
  final List<InfoData> data;
  int sortCol;
  bool sortType;

  StateData(this.state, this.data) {
    districts = _dummyData();
    columns = _createCols();
    sortCol = 1;
    sortType = false;
    refresh();
  }

  Future<void> refresh() async {
    districts = await _fetchData();
    sort();
    notifyListeners();
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

  List<DistrictData> _dummyData() {
    return [DistrictData('Dummy', 0)];
  }

  List<ColData> _createCols() {
    List<ColData> temp = List();
    temp.add(ColData("DISTRICT", false));
    temp.add(ColData("CNFMD", true));
    return temp;
  }

  Future<List<DistrictData>> _fetchData() async {
    var res = await http
        .get("https://api.covid19india.org/v2/state_district_wise.json");
    List<dynamic> body = jsonDecode(res.body);
    Map<String, dynamic> item = body.firstWhere((element) {
      Map<String, dynamic> el = element;
      return (el['state'] == this.state);
    });
    List<dynamic> data = item['districtData'];
    List<DistrictData> temp =
        data.map((e) => DistrictData.fromJson(e)).toList();
    return temp;
  }
}

class DistrictData {
  final String name;
  final int confirmed;

  DistrictData(this.name, this.confirmed);

  DistrictData.fromJson(Map<String, dynamic> json)
      : name = json['district'],
        confirmed = json['confirmed'];

  List<String> getRow() {
    return [this.name, this.confirmed.toString()];
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
