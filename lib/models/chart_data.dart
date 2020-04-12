/// Data class for Charts

import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';

class ChartData {
  final String title;
  final List<TimeSeriesData> data;
  final Color color;

  ChartData(this.title, this.data, this.color);
}
