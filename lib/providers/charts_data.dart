import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts_flutter;

class ChartsData extends ChangeNotifier {
  List<Chart> charts;
  double height;

  ChartsData(Size size) {
    charts = _dummyData();
    height = _calcHeight(size);
    refresh();
  }

  void refreshSize(Size size) {
    height = _calcHeight(size);
  }

  double _calcHeight(Size size) {
    return size.width * 0.65;
  }

  List<Chart> _dummyData() {
    return [
      Chart("Loading", [TimeSeriesData(DateTime.now(), 0)],
          charts_flutter.MaterialPalette.red.shadeDefault)
    ];
  }

  Future<void> refresh() async {
    var data = await _fetchData();
    charts = _chartsPlot(data);
    notifyListeners();
  }

  List<Chart> _chartsPlot(List<dynamic> data) {
    List<Chart> temp = List();
    temp.add(Chart("Confirmed", _chartPlot(data, 'totalconfirmed'),
        charts_flutter.MaterialPalette.red.shadeDefault));
    temp.add(Chart("Recovered", _chartPlot(data, "totalrecovered"),
        charts_flutter.MaterialPalette.green.shadeDefault));
    temp.add(Chart("Deceased", _chartPlot(data, "totaldeceased"),
        charts_flutter.MaterialPalette.blue.shadeDefault));
    return temp;
  }

  List<TimeSeriesData> _chartPlot(List<dynamic> data, String field) {
    return data.map((e) => TimeSeriesData.fromJson(e, field)).toList();
  }

  Future<List<dynamic>> _fetchData() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> timeSeries = body['cases_time_series'];
    timeSeries.removeRange(0, timeSeries.length - 30);
    return timeSeries;
  }
}

class Chart {
  final String title;
  final List<TimeSeriesData> data;
  final charts_flutter.Color color;

  Chart(this.title, this.data, this.color);
}
