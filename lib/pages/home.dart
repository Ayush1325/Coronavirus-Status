import 'package:coronavirusstatus/components/info_list.dart';
import 'package:coronavirusstatus/components/last_updated.dart';
import 'package:coronavirusstatus/components/states_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/providers/general_data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GeneralData>(
      create: (_) => GeneralData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: NavDrawer(),
        body: InfoList(),
        bottomSheet: LastUpdated(),
      ),
    );
  }
}
