/// Provider for all charts.

import 'package:coronavirusstatus/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class ChartHelper extends ChangeNotifier {
  DateTime selectedDate;
  List<DisplayData> displayData;
  List<ChartData> chartData;

  ChartHelper(this.chartData) {
    _initialData();
  }

  ChartHelper update(List<ChartData> data) {
    this.chartData = data;
    this.selectedDate = this.chartData.first.data.last.date;
    List<int> temp = this.chartData.map((e) => e.data.length - 1).toList();
    this.displayData = _genDisplay(this.selectedDate, temp);
    return this;
  }

  void selectDate(DateTime date, List<int> indexes) {
    this.selectedDate = date;
    this.displayData = _genDisplay(date, indexes);
    notifyListeners();
  }

  void _initialData() {
    this.selectedDate = this.chartData.first.data.last.date;
    List<int> temp = this.chartData.map((e) => e.data.length - 1).toList();
    this.displayData = _genDisplay(this.selectedDate, temp);
    notifyListeners();
  }

  List<DisplayData> _genDisplay(DateTime date, List<int> indexes) {
    if (chartData.length == 1) {
      return indexes
          .asMap()
          .map((key, value) => MapEntry(
              key,
              DisplayData("\n${chartData[key].data[value].value}",
                  constants.DataColors.confirmed)))
          .values
          .toList();
    }
    return indexes
        .asMap()
        .map((key, value) {
          ChartData temp = chartData[key];
          return MapEntry(
              key,
              DisplayData(
                  "\n${constants.Titles.mapper[temp.title]}: ${temp.data[value].value}",
                  temp.color));
        })
        .values
        .toList();
  }
}

class DisplayData {
  final String value;
  final Color color;

  DisplayData(this.value, this.color);
}
