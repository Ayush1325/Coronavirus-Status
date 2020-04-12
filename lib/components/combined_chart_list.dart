/// List for showing combined charts.

import 'package:coronavirusstatus/components/common_bar_chart.dart';
import 'package:coronavirusstatus/components/common_time_chart.dart';
import 'package:coronavirusstatus/providers/chart_helper.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CombinedChartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChartsData>(
      builder: (context, model, _) => RefreshIndicator(
        onRefresh: model.refresh,
        child: OrientationBuilder(builder: (context, _) {
          model.refreshSize(MediaQuery.of(context).size);
          return ListView(
            children: <Widget>[
              ChangeNotifierProxyProvider<ChartsData, ChartHelper>(
                create: (_) => ChartHelper(model.charts[0]),
                update: (_, model, chartModel) =>
                    chartModel.update(model.charts[0]),
                child: CommonTimeChart(
                  title: "Culminative",
                  height: model.height,
                ),
              ),
              ChangeNotifierProxyProvider<ChartsData, ChartHelper>(
                create: (_) => ChartHelper(model.charts[1]),
                update: (_, model, chartModel) =>
                    chartModel.update(model.charts[1]),
                child: CommonBarChart(
                  title: "Daily",
                  height: model.height,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
