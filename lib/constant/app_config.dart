import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:path_provider/path_provider.dart';

class AppConfig {
  static late Directory dir;
  static late String udid;

  static Future<void> initialize() async {
    dir = await getApplicationDocumentsDirectory();
    print("dir $dir");
    const AndroidId androidId = AndroidId();
    udid = await androidId.getId() ?? "";
    print("udid $udid");
  }
}
