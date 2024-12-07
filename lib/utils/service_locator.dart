import 'package:get_it/get_it.dart';
import 'package:sampling_machine_mobile_testing/data/machine_api/machine_api_service.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_service.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static Future initialize() async {
    final SharedPrefs prefs = SharedPrefs();
    await prefs.initialize();
    locator.registerSingleton(prefs);
    locator.registerSingleton(MachineApiService());
    locator.registerSingleton(ScanBillService());
  }
}
