import 'dart:convert';

import 'package:coronavirusstatus/helpers/permissions.dart';
import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class Updater {
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
                  _update(dat.apks[platform]);
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

  Future<bool> _check(String version) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return (packageInfo.version.compareTo(version) == -1);
  }

  Future<Data> _fetchData() async {
    Map<String, String> ans = Map();
    var res = await http.get(
        "https://api.github.com/repos/Ayush1325/Coronavirus-Status/releases/latest");
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

  Future<String> _platform() async {
    Map<String, String> abis = {
      'x86': 'app-x86_64-release.apk',
      'arm64-v8a': 'app-arm64-v8a-release.apk',
      'armeabi-v7a': 'app-armeabi-v7a-release.apk',
    };
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var temp = androidInfo.supportedAbis;
    for (MapEntry e in abis.entries) {
      if (temp.contains(e.key)) {
        return e.value;
      }
    }
    return "";
  }

  void _update(String url) {
    try {
      OtaUpdate().execute(url, destinationFilename: 'covid19.apk').listen(
        (OtaEvent event) {
          print('EVENT: ${event.status} : ${event.value}');
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
}

class Data {
  final String version;
  final Map<String, String> apks;

  Data(this.version, this.apks);
}
