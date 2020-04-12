/// Provides data for settings page

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class SettingsData extends ChangeNotifier {
  String version;

  SettingsData() {
    _dummyData();
    refresh();
  }

  void _dummyData() {
    this.version = "";
  }

  void refresh() async {
    this.version = await _appVersion();
    notifyListeners();
  }

  static Future<String> _appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
