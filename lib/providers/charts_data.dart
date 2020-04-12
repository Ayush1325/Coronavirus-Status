/// Provider for data for different charts and graphs.
/// There is also [charts_position] for managing single chart gestures.

import 'package:coronavirusstatus/models/chart_data.dart';
import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class ChartsData extends ChangeNotifier {
  List<List<ChartData>> charts;
  double height;
  static const height_multiplier = 0.65;

  ChartsData(Size size) {
    _dummyData();
    height = _calcHeight(size);
    refresh();
  }

  void refreshSize(Size size) {
    height = _calcHeight(size);
  }

  Future<void> refresh() async {
    var data = await _fetchData();
    charts = _chartsPlot(data);
    notifyListeners();
  }

  void _dummyData() {
    var temp = [
      ChartData("Loading", [TimeSeriesData(DateTime.now(), 0)], Colors.red)
    ];
    this.charts.add(temp);
    this.charts.add(temp);
  }

  static double _calcHeight(Size size) {
    return size.width * height_multiplier;
  }

  static List<List<ChartData>> _chartsPlot(List<dynamic> data) {
    List<List<ChartData>> temp = List();
    temp.add(_linePlot(data));
    temp.add(_barPlot(data));
    return temp;
  }

  static List<ChartData> _linePlot(List<dynamic> data) {
    List<ChartData> temp = List();
    temp.add(ChartData(
        constants.Titles.fullConfirmed,
        _chartPlot(data, constants.IndianTrackerJsonTags.totalConfirmed),
        constants.DataColors.confirmed));
    temp.add(ChartData(
        constants.Titles.fullRecovered,
        _chartPlot(data, constants.IndianTrackerJsonTags.totalRecovered),
        constants.DataColors.recovered));
    temp.add(ChartData(
        constants.Titles.fullDeceased,
        _chartPlot(data, constants.IndianTrackerJsonTags.totalDeceased),
        constants.DataColors.deceased));
    return temp;
  }

  static List<ChartData> _barPlot(List<dynamic> data) {
    List<ChartData> temp = List();
    temp.add(ChartData(
        constants.Titles.fullConfirmed,
        _chartPlot(data, constants.IndianTrackerJsonTags.dailyConfirmed),
        constants.DataColors.confirmed));
    temp.add(ChartData(
        constants.Titles.fullRecovered,
        _chartPlot(data, constants.IndianTrackerJsonTags.dailyRecovered),
        constants.DataColors.recovered));
    temp.add(ChartData(
        constants.Titles.fullDeceased,
        _chartPlot(data, constants.IndianTrackerJsonTags.dailyDeceased),
        constants.DataColors.deceased));
    return temp;
  }

  static List<TimeSeriesData> _chartPlot(List<dynamic> data, String field) {
    return data.map((e) => TimeSeriesData.fromJson(e, field)).toList();
  }

  static Future<List<dynamic>> _fetchData() async {
    var res = await http.get(constants.IndianTrackerEndpoints.general);
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> timeSeries =
        body[constants.IndianTrackerJsonTags.caseTimeSeries];
    timeSeries.removeRange(0, timeSeries.length - 25);
    return timeSeries;
  }
}
