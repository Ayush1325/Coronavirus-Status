import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GeneralTimeChart extends StatelessWidget {
  final List<TimeSeriesData> data;
  final String title;
  final double height;
  final charts.Color color;

  GeneralTimeChart({Key key, this.title, this.data, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              this.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              height: this.height,
              child: charts.TimeSeriesChart(
                [
                  charts.Series<TimeSeriesData, DateTime>(
                    id: 'Confimed Cases',
                    domainFn: (TimeSeriesData dat, _) => dat.date,
                    measureFn: (TimeSeriesData dat, _) => dat.value,
                    data: this.data,
                    colorFn: (_, __) => this.color,
                  ),
                ],
                animate: false,
                domainAxis: new charts.DateTimeAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      color: charts.ColorUtil.fromDartColor(
                          Theme.of(context).textTheme.caption.color),
                      fontSize: 14,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts.MaterialPalette.gray.shadeDefault,
                    ),
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      color: charts.ColorUtil.fromDartColor(
                          Theme.of(context).textTheme.caption.color),
                      fontSize: 14,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts.MaterialPalette.gray.shadeDefault,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
