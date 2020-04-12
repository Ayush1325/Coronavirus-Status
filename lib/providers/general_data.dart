/// Provider for the home page.

import 'dart:convert';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class GeneralData extends ChangeNotifier {
  List<InfoData> data;
  DateTime lastUpdated;
  String delta;

  GeneralData() {
    this.data = List();
    _dummyData();
    refresh();
  }

  Future<void> refresh() async {
    var temp = await _fetchData();
    lastUpdated = temp.time;
    data = temp.data;
    delta = _setUpdated(lastUpdated);
    notifyListeners();
  }

  void _dummyData() {
    this.data.add(InfoData(
        constants.Titles.fullConfirmed, 0, 0, constants.DataColors.confirmed));
    this.data.add(InfoData(
        constants.Titles.fullActive, 0, 0, constants.DataColors.active));
    this.data.add(InfoData(
        constants.Titles.fullRecovered, 0, 0, constants.DataColors.recovered));
    this.data.add(InfoData(
        constants.Titles.fullDeceased, 0, 0, constants.DataColors.deceased));
    this.lastUpdated = DateTime.now();
    this.delta = _setUpdated(lastUpdated);
  }

  static String _setUpdated(DateTime time) {
    Duration temp = DateTime.now().difference(time);
    if (temp.inSeconds < 60) {
      return "${temp.inSeconds} Seconds";
    } else if (temp.inMinutes < 60) {
      return "${temp.inMinutes} Minutes";
    } else if (temp.inHours < 24) {
      return "${(temp.inHours + ((temp.inMinutes % 60) / 60)).ceil()} Hours";
    } else {
      return "${temp.inDays} Days";
    }
  }

  static Future<FetchedData> _fetchData() async {
    FetchedData temp = FetchedData();
    var res = await http.get(constants.IndianTrackerEndpoints.general);
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> states = body[constants.IndianTrackerJsonTags.stateList];
    Map<String, dynamic> total = states.first;
    temp.time = DateFormat(constants.IndianTrackerJsonTags.dateFormat)
        .parse(total[constants.IndianTrackerJsonTags.lastUpdate]);
    temp.data.add(InfoData(
        constants.Titles.fullConfirmed,
        int.parse(
            total[constants.IndianTrackerJsonTags.stateDistrictConfirmed]),
        int.parse(total[constants.IndianTrackerJsonTags.deltaConfirmed]),
        constants.DataColors.confirmed));
    temp.data.add(InfoData(
        constants.Titles.fullActive,
        int.parse(total[constants.IndianTrackerJsonTags.stateDistrictActive]),
        0,
        constants.DataColors.active));
    temp.data.add(InfoData(
        constants.Titles.fullRecovered,
        int.parse(
            total[constants.IndianTrackerJsonTags.stateDistrictRecovered]),
        int.parse(total[constants.IndianTrackerJsonTags.deltaRecovered]),
        constants.DataColors.recovered));
    temp.data.add(InfoData(
        constants.Titles.fullDeceased,
        int.parse(total[constants.IndianTrackerJsonTags.stateDistrictDeceased]),
        int.parse(total[constants.IndianTrackerJsonTags.deltaDeceased]),
        constants.DataColors.deceased));
    return temp;
  }
}

class FetchedData {
  DateTime time;
  List<InfoData> data;

  FetchedData() {
    data = List();
  }
}
