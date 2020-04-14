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
    this.width = _calcWidth(size);
    this.columns = _createCols(width);
    if (!width && this.sortCol > 2) {
      this.sortCol = (this.sortCol == 4) ? 2 : 1;
    }
    sort();
  }

  bool _calcWidth(Size size) {
    return (size.width > full_width);
  }

  Future<void> refresh() async {
    data = await _fetchData();
    notifyListeners();
  }

  void _dummyData() {
    this.data.add(Data("Loading", 0, 0, 0, 0, 0, 0, 0, 0));
  }

  void setSort(int index, bool type) {
    this.sortType = type;
    this.sortCol = index;
    sort();
    notifyListeners();
  }

  void sort() {
    this.data.sort((e1, e2) => e1.cmp(e2, sortCol, sortType, width));
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
    if (width) {
      temp.add(ColData(constants.Titles.abbrTested, true));
    }
    return temp;
  }

  static Future<List<Data>> _fetchData() async {
    List<Data> temp = List();
    var res1 = await http.get(constants.IndianTrackerEndpoints.general);
    var res2 = await http.get(constants.IndianTrackerEndpoints.stateTested);
    Map<String, dynamic> bodyData = jsonDecode(res1.body);
    Map<String, dynamic> bodyTested = jsonDecode(res2.body);
    List<dynamic> states = bodyData[constants.IndianTrackerJsonTags.stateList];
    List<dynamic> tested = bodyTested['states_tested_data'];
    states.forEach((element) {
      Map<String, dynamic> t = element;
      temp.add(Data.fromJson(t, _findTested(t['state'], tested)));
    });
    temp.removeAt(0);
    return temp;
  }

  static Map<String, dynamic> _findTested(String state, List<dynamic> tested) {
    Map<String, dynamic> ans = tested.reversed.firstWhere((element) {
      Map<String, dynamic> temp = element;
      return temp['state'] == state;
    }, orElse: () => {'totaltested': 0.toString()});

    try {
      int.parse(ans['totaltested']);
      return ans;
    } catch (_) {
      return {'totaltested': 0.toString()};
    }
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
  final int tested;

  Data(this.state, this.confirmed, this.deaths, this.active, this.recovered,
      this.deltaConfirmed, this.deltaRecovered, this.deltaDeaths, this.tested);

  Data.fromJson(Map<String, dynamic> json1, Map<String, dynamic> json2)
      : state = json1['state'],
        confirmed = int.parse(
            json1[constants.IndianTrackerJsonTags.stateDistrictConfirmed]),
        active = int.parse(
            json1[constants.IndianTrackerJsonTags.stateDistrictActive]),
        recovered = int.parse(
            json1[constants.IndianTrackerJsonTags.stateDistrictRecovered]),
        deaths = int.parse(
            json1[constants.IndianTrackerJsonTags.stateDistrictDeceased]),
        deltaConfirmed =
            int.parse(json1[constants.IndianTrackerJsonTags.deltaConfirmed]),
        deltaRecovered =
            int.parse(json1[constants.IndianTrackerJsonTags.deltaRecovered]),
        deltaDeaths =
            int.parse(json1[constants.IndianTrackerJsonTags.deltaDeceased]),
        tested = int.parse(json2['totaltested']);

  List<Widget> genRow(bool state, BuildContext context) {
    List<Widget> temp = List();
    temp.add(Text(
      this.state,
      style: Theme.of(context).textTheme.subtitle2,
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
    if (state) {
      temp.add(genWidget(this.tested, 0, constants.DataColors.tested));
    }
    return temp;
  }

  static Widget genWidget(int value, int delta, Color color) {
    if (delta == 0) {
      return Text(
        value.toString(),
      );
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
      InfoData(constants.Titles.fullTested, this.tested, 0,
          constants.DataColors.tested),
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
        case 5:
          temp = this.tested.compareTo(d.tested);
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
