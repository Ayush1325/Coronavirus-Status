import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';

class ChartPosition extends ChangeNotifier {
  List<TimeSeriesData> data;

  ChartPosition(this.data);

  void updatePos(List<TimeSeriesData> d) {
    data = d;
    notifyListeners();
  }

  ChartPosition update(List<TimeSeriesData> d) {
    data = d;
    return this;
  }
}
