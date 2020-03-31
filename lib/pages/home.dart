import 'package:coronavirusstatus/components/states_list.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusstatus/components/bubbles_list.dart';
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
          title: Text("Home"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "State",
              ),
              Tab(
                text: "Data",
              )
            ],
          ),
        ),
        drawer: NavDrawer(),
        body: ChangeNotifierProvider<GeneralData>(
          create: (_) => GeneralData(),
          child: TabBarView(
            children: <Widget>[
              StatesList(),
              BubblesList(),
            ],
          ),
        ),
      ),
    );
  }
}
