import 'package:coronavirusstatus/models/chart_data.dart';
import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChartsData extends ChangeNotifier {
  List<List<ChartData>> charts;
  double height;

  ChartsData(Size size) {
    charts = [_dummyData(), _dummyData()];
    height = _calcHeight(size);
    refresh();
  }

  void refreshSize(Size size) {
    height = _calcHeight(size);
  }

  double _calcHeight(Size size) {
    return size.width * 0.65;
  }

  List<ChartData> _dummyData() {
    return [
      ChartData("Loading", [TimeSeriesData(DateTime.now(), 0)], Colors.red)
    ];
  }

  Future<void> refresh() async {
    var data = await _fetchData();
    charts = _chartsPlot(data);
    notifyListeners();
  }

  List<List<ChartData>> _chartsPlot(List<dynamic> data) {
    List<List<ChartData>> temp = List();
    temp.add(_linePlot(data));
    temp.add(_barPlot(data));
    return temp;
  }

  List<ChartData> _linePlot(List<dynamic> data) {
    List<ChartData> temp = List();
    temp.add(
        ChartData("Confirmed", _chartPlot(data, 'totalconfirmed'), Colors.red));
    temp.add(ChartData(
        "Recovered", _chartPlot(data, "totalrecovered"), Colors.green));
    temp.add(
        ChartData("Deceased", _chartPlot(data, "totaldeceased"), Colors.blue));
    return temp;
  }

  List<ChartData> _barPlot(List<dynamic> data) {
    List<ChartData> temp = List();
    temp.add(
        ChartData("Confirmed", _chartPlot(data, 'dailyconfirmed'), Colors.red));
    temp.add(ChartData(
        "Recovered", _chartPlot(data, "dailyrecovered"), Colors.green));
    temp.add(
        ChartData("Deceased", _chartPlot(data, "dailydeceased"), Colors.blue));
    return temp;
  }

  List<TimeSeriesData> _chartPlot(List<dynamic> data, String field) {
    return data.map((e) => TimeSeriesData.fromJson(e, field)).toList();
  }

  Future<List<dynamic>> _fetchData() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> timeSeries = body['cases_time_series'];
    timeSeries.removeRange(0, timeSeries.length - 25);
    return timeSeries;
  }
}
