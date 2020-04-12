/// Common interface for all line charts.

import 'package:coronavirusstatus/models/time_series_data.dart';
import 'package:coronavirusstatus/providers/chart_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommonTimeChart extends StatelessWidget {
  final String title;
  final double height;

  CommonTimeChart({Key key, this.title, this.height});

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
                  DisplayInfo(),
                ],
              ),
            ),
            Container(
              height: this.height,
              child: charts.TimeSeriesChart(
                Provider.of<ChartHelper>(context)
                    .chartData
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
                  charts.InitialSelection(
                      selectedDataConfig: Provider.of<ChartHelper>(context)
                          .chartData
                          .map((e) => charts.SeriesDatumConfig<DateTime>(
                              e.title,
                              Provider.of<ChartHelper>(context).selectedDate))
                          .toList())
                ],
                selectionModels: [
                  charts.SelectionModelConfig(
                      type: charts.SelectionModelType.info,
                      changedListener: (charts.SelectionModel selectionModel) {
                        DateTime time =
                            selectionModel.selectedDatum.first.datum.date;
                        List<int> indexes = selectionModel.selectedDatum
                            .map((e) => e.index)
                            .toList();
                        Provider.of<ChartHelper>(context, listen: false)
                            .selectDate(time, indexes);
                      })
                ],
                animate: true,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartHelper>(
      builder: (context, model, _) => RichText(
        text: TextSpan(
          text: DateFormat("dd MMM").format(model.selectedDate),
          style: TextStyle(
            fontSize: 18,
          ),
          children: model.displayData
              .map((e) =>
                  TextSpan(text: e.value, style: TextStyle(color: e.color)))
              .toList(),
        ),
      ),
    );
  }
}
