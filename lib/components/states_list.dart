import 'package:coronavirusstatus/main.dart';
import 'package:coronavirusstatus/providers/general_data.dart';
import 'package:coronavirusstatus/providers/states_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StatesData>(builder: (context, model, _) {
      return ListView.builder(
          itemCount: model.keys.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(model.keys[index]),
              selected: (model.key == model.keys[index]),
              onTap: () {
                model.updateKey(model.keys[index]);
              },
            );
          });
    });
  }
}
