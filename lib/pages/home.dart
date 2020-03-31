import 'package:flutter/material.dart';
import 'package:coronavirusstatus/components/bubbles_list.dart';
import 'package:provider/provider.dart';
import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/providers/india.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: NavDrawer(),
      body: ChangeNotifierProvider<India>(
        create: (_) => India(),
        child: BubblesList(),
      ),
    );
  }
}
