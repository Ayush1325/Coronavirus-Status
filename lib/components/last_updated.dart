/// Last Updated Bottom sheet.

import 'package:coronavirusstatus/providers/general_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LastUpdated extends StatelessWidget {
  final String delta;
  final DateTime lastUpdated;

  LastUpdated({Key key, this.delta, this.lastUpdated});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Last Updated: $delta ago",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat("dd MMM, HH:mm").format(lastUpdated) + " IST",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
