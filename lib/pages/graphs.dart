/// Graphs Page

import 'package:coronavirusstatus/components/charts_list.dart';
import 'package:coronavirusstatus/components/combined_chart_list.dart';
import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Graphs"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Combined"),
              ),
              Tab(
                child: Text('Culminative'),
              ),
              Tab(
                child: Text('Daily'),
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider<ChartsData>(
          create: (_) => ChartsData(size),
          child: TabBarView(
            children: <Widget>[
              CombinedChartList(),
              ChartsList(
                pos: 0,
              ),
              ChartsList(
                pos: 1,
              ),
            ],
          ),
        ),
        drawer: NavDrawer(),
      ),
    );
  }
}
