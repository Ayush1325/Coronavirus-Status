/// Settings Page

import 'package:coronavirusstatus/components/nav_drawer.dart';
import 'package:coronavirusstatus/components/settings_list.dart';
import 'package:coronavirusstatus/providers/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: NavDrawer(),
      body: ChangeNotifierProvider(
        create: (_) => SettingsData(),
        child: SettingsList(),
      ),
    );
  }
}
