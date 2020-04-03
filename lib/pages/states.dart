import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/components/states_table.dart';
import 'package:coronavirusstatus/providers/states_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class States extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("States"),
      ),
      drawer: NavDrawer(),
      body: ChangeNotifierProvider<StatesData>(
        create: (_) => StatesData(MediaQuery.of(context).size),
        child: StatesTable(),
      ),
    );
  }
}
