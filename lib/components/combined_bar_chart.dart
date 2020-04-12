/// Chart for combining daily data.

import 'package:coronavirusstatus/models/chart_data.dart';
import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:coronavirusstatus/providers/chart_position.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CombinedBarChart extends StatelessWidget {
  final String title;
  final List<ChartData> data;
  final double height;

  CombinedBarChart({Key key, this.title, this.data, this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  DisplayInfo(data: data),
                ],
              ),
            ),
            Container(
              height: this.height,
              child: charts.TimeSeriesChart(
                this
                    .data
                    .map(
                      (e) => charts.Series<TimeSeriesData, DateTime>(
                        id: e.title,
                        domainFn: (TimeSeriesData dat, _) => dat.date,
                        measureFn: (TimeSeriesData dat, _) => dat.value,
                        data: e.data,
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(e.color),
                      ),
                    )
                    .toList(),
                behaviors: [
                  charts.SelectNearest(),
                  charts.DomainHighlighter(),
                  charts.InitialSelection(
                      selectedDataConfig: Provider.of<ChartPosition>(context)
                          .data
                          .asMap()
                          .map((i, e) => MapEntry(
                              i,
                              charts.SeriesDatumConfig<DateTime>(
                                  this.data[i].title, e.date)))
                          .values
                          .toList())
                ],
                selectionModels: [
                  charts.SelectionModelConfig(
                      type: charts.SelectionModelType.info,
                      changedListener: (charts.SelectionModel model) {
                        final selectedDatum = model.selectedDatum;

                        DateTime time = model.selectedDatum.first.datum.date;
                        List<TimeSeriesData> temp = selectedDatum
                            .map((e) => TimeSeriesData(time, e.datum.value))
                            .toList();

                        Provider.of<ChartPosition>(context, listen: false)
                            .updatePos(temp);
                      })
                ],
                animate: true,
                defaultRenderer: new charts.BarRendererConfig<DateTime>(
                  groupingType: charts.BarGroupingType.stacked,
                ),
                defaultInteractions: false,
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

class DisplayInfo extends StatelessWidget {
  const DisplayInfo({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartPosition>(
      builder: (context, model, _) => RichText(
        text: TextSpan(
          text: DateFormat("dd MMM").format(model.data[0].date),
          style: TextStyle(
            fontSize: 18,
          ),
          children: model.data
              .asMap()
              .map((i, e) => MapEntry(
                  i,
                  TextSpan(
                      text:
                          "\n${this.data[i].title.substring(0, 3).toUpperCase()}: ${e.value.toString()}",
                      style: TextStyle(
                        color: this.data[i].color,
                      ))))
              .values
              .toList(),
        ),
      ),
    );
  }
}
