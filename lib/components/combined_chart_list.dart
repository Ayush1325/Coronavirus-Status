import 'package:coronavirusstatus/components/combined_bar_chart.dart';
import 'package:coronavirusstatus/providers/chart_position.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'combined_time_chart.dart';

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
              ChangeNotifierProxyProvider<ChartsData, ChartPosition>(
                create: (_) => ChartPosition(
                    model.charts[0].map((e) => e.data.last).toList()),
                update: (_, model, chartPosition) => chartPosition
                    .update(model.charts[0].map((e) => e.data.last).toList()),
                child: CombinedTimeChart(
                  title: "Culminative",
                  data: model.charts[0],
                  height: model.height,
                ),
              ),
              ChangeNotifierProxyProvider<ChartsData, ChartPosition>(
                create: (_) => ChartPosition(
                    model.charts[1].map((e) => e.data.last).toList()),
                update: (_, model, chartPosition) => chartPosition
                    .update(model.charts[1].map((e) => e.data.last).toList()),
                child: CombinedBarChart(
                  title: "Daily",
                  data: model.charts[1],
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
