/// Responsible for app updating.

import 'dart:convert';

import 'package:coronavirusstatus/helpers/permissions.dart';
import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:coronavirusstatus/helpers/constants.dart' as constants;

class Updater {
  static const Map<String, String> ABIs = {
    'x86': 'app-x86_64-release.apk',
    'arm64-v8a': 'app-arm64-v8a-release.apk',
    'armeabi-v7a': 'app-armeabi-v7a-release.apk',
  };

  void start(BuildContext context) async {
    if (await Permissions.storagePermission()) {
      if (Platform.isAndroid) {
        var dat = await _fetchData();
        if (await _check(dat.version)) {
          var platform = await _platform();
          if (platform != "") {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('New Version Available'),
              action: SnackBarAction(
                label: 'Update',
                onPressed: () {
                  _update(dat.APKs[platform], context);
                },
              ),
            ));
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Alread On Newset Version'),
          ));
        }
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not get storage permissions'),
      ));
    }
  }

  static Future<bool> _check(String version) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return (packageInfo.version.compareTo(version) == -1);
  }

  static Future<Data> _fetchData() async {
    var res = await http.get(constants.updateURL);
    Map<String, dynamic> body = jsonDecode(res.body);

    String version = body["tag_name"];
    version = version.substring(1);
    List<dynamic> assets = body['assets'];
    Map<String, String> apks = Map.fromEntries(assets.map((e) {
      Map<String, dynamic> item = e;
      return MapEntry(
          item['name'].toString(), item['browser_download_url'].toString());
    }));
    return Data(version, apks);
  }

  static Future<String> _platform() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var temp = androidInfo.supportedAbis;
    for (MapEntry e in ABIs.entries) {
      if (temp.contains(e.key)) {
        return e.value;
      }
    }
    return "";
  }

  void _update(String url, BuildContext context) {
    try {
      OtaUpdate().execute(url, destinationFilename: 'covid19.apk');
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed to download update'),
      ));
    }
  }
}

class Data {
  final String version;
  final Map<String, String> APKs;

  Data(this.version, this.APKs);
}
