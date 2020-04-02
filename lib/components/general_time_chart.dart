import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GeneralTimeChart extends StatelessWidget {
  final List<TimeSeriesData> data;
  final String title;

  GeneralTimeChart({Key key, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Container(
              height: 250,
              child: charts.TimeSeriesChart(
                [
                  charts.Series<TimeSeriesData, DateTime>(
                    id: 'Confimed Cases',
                    domainFn: (TimeSeriesData dat, _) => dat.date,
                    measureFn: (TimeSeriesData dat, _) => dat.value,
                    data: this.data,
                    colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                  ),
                ],
                animate: true,
                domainAxis: new charts.EndPointsTimeAxisSpec(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
