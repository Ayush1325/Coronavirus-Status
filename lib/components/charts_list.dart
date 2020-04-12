/// List to show Daily and Cumulative charts.

import 'package:coronavirusstatus/components/general_bar_chart.dart';
import 'package:coronavirusstatus/components/general_time_chart.dart';
import 'package:coronavirusstatus/providers/chart_position.dart';
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
                  return ChangeNotifierProvider<ChartPosition>(
                    create: (_) =>
                        ChartPosition([model.charts[pos][index].data.last]),
                    child: GeneralTimeChart(
                      title: model.charts[pos][index].title,
                      data: model.charts[pos][index].data,
                      height: model.height,
                      color: model.charts[pos][index].color,
                    ),
                  );
                } else {
                  return ChangeNotifierProvider<ChartPosition>(
                    create: (_) =>
                        ChartPosition([model.charts[pos][index].data.last]),
                    child: GeneralBarChart(
                      title: model.charts[pos][index].title,
                      data: model.charts[pos][index].data,
                      height: model.height,
                      color: model.charts[pos][index].color,
                    ),
                  );
                }
              });
        }),
      ),
    );
  }
}
