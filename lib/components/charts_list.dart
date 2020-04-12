import 'package:coronavirusstatus/components/common_bar_chart.dart';
import 'package:coronavirusstatus/components/common_time_chart.dart';

/// List to show Daily and Cumulative charts.

import 'package:coronavirusstatus/providers/chart_helper.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsList<T extends StatelessWidget> extends StatelessWidget {
  final int pos;

  ChartsList({Key key, this.pos});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartsData>(
      builder: (context, model, _) => RefreshIndicator(
        onRefresh: model.refresh,
        child: OrientationBuilder(builder: (context, _) {
          model.refreshSize(MediaQuery.of(context).size);
          return ListView.builder(
              itemCount: model.charts[pos].length,
              itemBuilder: (context, index) {
                if (pos == 0) {
                  return ChangeNotifierProxyProvider<ChartsData, ChartHelper>(
                    create: (_) => ChartHelper([model.charts[pos][index]]),
                    update: (_, model, chartModel) =>
                        chartModel.update([model.charts[pos][index]]),
                    child: CommonTimeChart(
                      title: "Culminative",
                      height: model.height,
                    ),
                  );
                } else {
                  return ChangeNotifierProxyProvider<ChartsData, ChartHelper>(
                    create: (_) => ChartHelper([model.charts[pos][index]]),
                    update: (_, model, chartModel) =>
                        chartModel.update([model.charts[pos][index]]),
                    child: CommonBarChart(
                      title: "Culminative",
                      height: model.height,
                    ),
                  );
                }
              });
        }),
      ),
    );
  }
}
