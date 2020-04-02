import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChartsData extends ChangeNotifier {
  List<Chart> charts;

  ChartsData() {
    charts = _dummyData();
    refresh();
  }

  List<Chart> _dummyData() {
    return [
      Chart("Loading", [TimeSeriesData(DateTime.now(), 0)])
    ];
  }

  Future<void> refresh() async {
    var data = await _fetchData();
    charts = _chartsPlot(data);
    notifyListeners();
  }

  List<Chart> _chartsPlot(List<dynamic> data) {
    List<Chart> temp = List();
    temp.add(Chart("Confirmed", _chartPlot(data, 'totalconfirmed')));
    temp.add(Chart("Recovered", _chartPlot(data, "totalrecovered")));
    temp.add(Chart("Deceased", _chartPlot(data, "totaldeceased")));
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

  Chart(this.title, this.data);
}
