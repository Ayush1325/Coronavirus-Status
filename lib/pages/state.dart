/// Page for single state data.

import 'package:coronavirusstatus/components/state_list.dart';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:coronavirusstatus/providers/state_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateInfo extends StatelessWidget {
  final String state;
  final List<InfoData> data;

  StateInfo({Key key, this.state, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.state),
      ),
      body: ChangeNotifierProvider<StateData>(
        create: (_) => StateData(this.state, this.data),
        child: StateList(),
      ),
    );
  }
}
