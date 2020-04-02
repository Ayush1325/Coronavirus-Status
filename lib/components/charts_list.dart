import 'package:coronavirusstatus/components/general_time_chart.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChartsData>(
      builder: (context, model, _) => ListView.builder(
        itemCount: model.charts.length,
        itemBuilder: (context, index) => GeneralTimeChart(
          title: model.charts[index].title,
          data: model.charts[index].data,
        ),
      ),
    );
  }
}
