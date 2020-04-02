import 'package:coronavirusstatus/components/charts_list.dart';
import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/providers/charts_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graphs"),
      ),
      body: ChangeNotifierProvider<ChartsData>(
        create: (_) => ChartsData(),
        child: ChartsList(),
      ),
      drawer: NavDrawer(),
    );
  }
}
