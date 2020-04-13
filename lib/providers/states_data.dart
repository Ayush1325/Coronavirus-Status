/// Provider for states table

import 'dart:convert';

import 'package:coronavirusstatus/models/info_data.dart';
import 'package:coronavirusstatus/models/table_col_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class StatesData extends ChangeNotifier {
  List<Data> data;
  List<ColData> columns;
  int sortCol;
  bool sortType;
  bool width;
  static const full_width = 700;

  StatesData(Size size) {
    this.data = List();
    _dummyData();
    width = _calcWidth(size);
    columns = _createCols(width);
    sortCol = 1;
    sortType = false;
    refresh();
  }

  void refreshSize(Size size) {
    width = _calcWidth(size);
    columns = _createCols(width);
  }

  bool _calcWidth(Size size) {
    return (size.width > full_width);
  }

  Future<void> refresh() async {
    data = await _fetchData();
    notifyListeners();
  }

  void _dummyData() {
    this.data.add(Data("Loading", 0, 0, 0, 0, 0, 0, 0));
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

  static List<ColData> _createCols(bool width) {
    List<ColData> temp = List();
    temp.add(ColData("State/Ut", false));
    temp.add(ColData(constants.Titles.abbrConfirmed, true));
    if (width) {
      temp.add(ColData(constants.Titles.abbrActive, true));
      temp.add(ColData(constants.Titles.abbrRecovered, true));
    }
    temp.add(ColData(constants.Titles.abbrDeceased, true));
    return temp;
  }

  static Future<List<Data>> _fetchData() async {
    List<Data> temp = List();
    var res = await http.get(constants.IndianTrackerEndpoints.general);
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body[constants.IndianTrackerJsonTags.stateList];
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
        confirmed = int.parse(
            json[constants.IndianTrackerJsonTags.stateDistrictConfirmed]),
        active = int.parse(
            json[constants.IndianTrackerJsonTags.stateDistrictActive]),
        recovered = int.parse(
            json[constants.IndianTrackerJsonTags.stateDistrictRecovered]),
        deaths = int.parse(
            json[constants.IndianTrackerJsonTags.stateDistrictDeceased]),
        deltaConfirmed =
            int.parse(json[constants.IndianTrackerJsonTags.deltaConfirmed]),
        deltaRecovered =
            int.parse(json[constants.IndianTrackerJsonTags.deltaRecovered]),
        deltaDeaths =
            int.parse(json[constants.IndianTrackerJsonTags.deltaDeceased]);

  List<Widget> genRow(bool state) {
    List<Widget> temp = List();
    temp.add(Text(
      this.state,
      style: TextStyle(color: Colors.white),
    ));
    temp.add(genWidget(
        this.confirmed, this.deltaConfirmed, constants.DataColors.confirmed));
    if (state) {
      temp.add(genWidget(this.active, 0, constants.DataColors.active));
      temp.add(genWidget(
          this.recovered, this.deltaRecovered, constants.DataColors.recovered));
    }
    temp.add(genWidget(
        this.deaths, this.deltaDeaths, constants.DataColors.deceased));
    return temp;
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

  List<InfoData> getStateData() {
    return [
      InfoData(constants.Titles.fullConfirmed, this.confirmed,
          this.deltaConfirmed, constants.DataColors.confirmed),
      InfoData(constants.Titles.fullActive, this.active, 0,
          constants.DataColors.active),
      InfoData(constants.Titles.fullRecovered, this.recovered,
          this.deltaRecovered, constants.DataColors.recovered),
      InfoData(constants.Titles.fullDeceased, this.deaths, this.deltaDeaths,
          constants.DataColors.deceased),
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
