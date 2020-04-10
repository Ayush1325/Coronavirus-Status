import 'package:intl/intl.dart';

class TimeSeriesData {
  final DateTime date;
  final int value;

  TimeSeriesData(this.date, this.value);

  TimeSeriesData.fromJson(Map<String, dynamic> json, String field)
      : date = DateFormat("dd MMMM yyyy").parse(json['date'] + "2020"),
        value = int.parse(json[field]);
}
