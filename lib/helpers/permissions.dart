/// Manages App permissions.

import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static void requestPermission() async {
    if (!await Permission.storage.isPermanentlyDenied) {
      await Permission.storage.request();
    }
  }

  static Future<bool> storagePermission() async {
    return Permission.storage.isGranted;
  }
}
