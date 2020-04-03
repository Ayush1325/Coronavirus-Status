import 'package:coronavirusstatus/components/state_list.dart';
import 'package:coronavirusstatus/models/info_data.dart';
import 'package:coronavirusstatus/providers/state_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateInfo extends StatelessWidget {
  String state;
  int confirmed;
  int active;
  int recovered;
  int deaths;
  List<InfoData> data;

  StateInfo({Key key, List<dynamic> dat}) {
    state = dat[0];
    confirmed = dat[1];
    active = dat[2];
    recovered = dat[3];
    deaths = dat[4];
    data = List();
    data.add(InfoData('Confirmed', confirmed, dat[5], Colors.red));
    data.add(InfoData("Active", active, 0, Colors.blue));
    data.add(InfoData("Recovered", recovered, dat[6], Colors.green));
    data.add(InfoData("Deceased", deaths, dat[7], Colors.blueGrey[300]));
  }

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
