/// Home Page

import 'package:coronavirusstatus/components/info_list.dart';
import 'package:coronavirusstatus/components/last_updated.dart';
import 'package:coronavirusstatus/components/updates_list.dart';
import 'package:coronavirusstatus/providers/updates_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/providers/general_data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Data",
              ),
              Tab(
                text: "Updates",
              )
            ],
          ),
        ),
        drawer: NavDrawer(),
        body: TabBarView(
          children: <Widget>[
            ChangeNotifierProvider<GeneralData>(
              create: (_) => GeneralData(),
              child: InfoList(),
            ),
            ChangeNotifierProvider<UpdatesData>(
              create: (_) => UpdatesData(),
              child: UpdatesList(),
            ),
          ],
        ),
      ),
    );
  }
}
