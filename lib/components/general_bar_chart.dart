import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:coronavirusstatus/providers/chart_position.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GeneralBarChart extends StatelessWidget {
  final List<TimeSeriesData> data;
  final String title;
  final double height;
  final Color color;

  GeneralBarChart({Key key, this.title, this.data, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  Consumer<ChartPosition>(
                    builder: (context, model, _) => RichText(
                      text: TextSpan(
                          text: DateFormat("dd MMM").format(model.data.date),
                          style: TextStyle(
                            color: this.color,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: model.data.value.toString(),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: this.height,
              child: charts.TimeSeriesChart(
                [
                  charts.Series<TimeSeriesData, DateTime>(
                    id: this.title,
                    domainFn: (TimeSeriesData dat, _) => dat.date,
                    measureFn: (TimeSeriesData dat, _) => dat.value,
                    data: this.data,
                    colorFn: (_, __) =>
                        charts.ColorUtil.fromDartColor(this.color),
                  ),
                ],
                selectionModels: [
                  charts.SelectionModelConfig(
                      changedListener: (charts.SelectionModel model) {
                    if (model.hasDatumSelection) {
                      TimeSeriesData temp = TimeSeriesData(
                          model.selectedSeries[0]
                              .domainFn(model.selectedDatum[0].index),
                          model.selectedSeries[0]
                              .measureFn(model.selectedDatum[0].index));
                      Provider.of<ChartPosition>(context, listen: false)
                          .updatePos(temp);
                    }
                  })
                ],
                animate: true,
                defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                defaultInteractions: false,
                behaviors: [
                  charts.SelectNearest(),
                  charts.DomainHighlighter(),
                  charts.InitialSelection(selectedDataConfig: [
                    charts.SeriesDatumConfig<DateTime>(
                      this.title,
                      Provider.of<ChartPosition>(context).data.date,
                    )
                  ])
                ],
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
