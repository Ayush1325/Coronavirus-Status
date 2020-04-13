/// List to show info items.

import 'package:coronavirusstatus/components/info_item.dart';
import 'package:coronavirusstatus/components/last_updated.dart';
import 'package:coronavirusstatus/providers/general_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralData>(
        builder: (context, model, _) => Stack(
              fit: StackFit.expand,
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: model.refresh,
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(2, 5, 2, 100),
                    itemBuilder: (context, index) => InfoItem(
                      title: model.data[index].title,
                      count: model.data[index].num,
                      delta: model.data[index].delta,
                      color: model.data[index].color,
                    ),
                    itemCount: model.data.length,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LastUpdated(
                    delta: model.delta,
                    lastUpdated: model.lastUpdated,
                  ),
                ),
              ],
            ));
  }
}
