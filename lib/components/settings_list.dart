/// List for settings item.

import 'package:coronavirusstatus/helpers/permissions.dart';
import 'package:coronavirusstatus/helpers/updater.dart';
import 'package:coronavirusstatus/providers/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsData>(
      builder: (context, model, _) => ListView(
        children: <Widget>[
          UpdateItem(
            version: model.version,
          ),
        ],
      ),
    );
  }
}

class UpdateItem extends StatelessWidget {
  final String version;

  const UpdateItem({
    Key key,
    this.version,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Check For Updates'),
      subtitle: Text(this.version),
      onTap: () {
        Permissions.requestPermission();
        Updater().start(context);
      },
      trailing: Icon(Icons.refresh),
    );
  }
}
