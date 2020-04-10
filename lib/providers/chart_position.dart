import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';

class ChartPosition extends ChangeNotifier {
  TimeSeriesData data;

  ChartPosition(this.data);

  void updatePos(TimeSeriesData d) {
    data = d;
    notifyListeners();
  }
}
