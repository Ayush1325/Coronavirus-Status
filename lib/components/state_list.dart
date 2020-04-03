import 'package:coronavirusstatus/components/district_table.dart';
import 'package:coronavirusstatus/providers/state_data.dart';
import 'info_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateData>(
      builder: (context, model, _) => ListView(
        padding: EdgeInsets.fromLTRB(2, 5, 2, 0),
        children: <Widget>[
          ...model.data
              .map((e) => InfoItem(
                    title: e.title,
                    count: e.num,
                    delta: e.delta,
                    color: e.color,
                  ))
              .toList(),
          DistrictTable(),
        ],
      ),
    );
  }
}
