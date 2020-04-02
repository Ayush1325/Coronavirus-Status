import 'package:intl/intl.dart';

class TimeSeriesData {
  final DateTime date;
  final int value;

  TimeSeriesData(this.date, this.value);

  TimeSeriesData.fromJson(Map<String, dynamic> json, String field)
      : date = DateFormat("dd MMMM").parse(json['date']),
        value = int.parse(json[field]);
}
