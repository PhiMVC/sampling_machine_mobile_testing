// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sampling_machine_mobile_testing/constant/app_config.dart';
import 'package:sampling_machine_mobile_testing/model/stack_model_hive.dart';

List<StackModelHive> listStackModel = [
  StackModelHive(
    '1 và 2',
    1,
  ),
  StackModelHive('3 và 4', 3),
  StackModelHive('5 và 6', 5),
  StackModelHive('7 và 8', 7),
  StackModelHive(
    '11 và 12',
    11,
  ),
  StackModelHive('13 và 14', 13),
  StackModelHive('15 và 16', 15),
  StackModelHive('17 và 18', 17),
  StackModelHive('21 và 22', 21),
  StackModelHive('23 và 24', 23),
  StackModelHive('25 và 26', 25),
  StackModelHive(
    '27 và 28',
    27,
  ),
  StackModelHive('31 và 32', 31),
  StackModelHive(
    '33 và 34',
    33,
  ),
  StackModelHive('35 và 36', 35),
  StackModelHive('37 và 38', 37),
  StackModelHive('41 và 42', 41),
  StackModelHive('43 và 44', 43),
  StackModelHive('45 và 46', 45),
  StackModelHive('47 và 48', 47),
  StackModelHive('51 và 52', 51),
  StackModelHive('53 và 54', 53),
  StackModelHive('55 và 56', 55),
  StackModelHive('57 và 58', 57),
];

class SharedPrefs {
  SharedPrefs();
  late Box config;
  late Box<StackModelHive> stack;
  late Box scanSnap;
  Future<void> initialize() async {
    final dir = AppConfig.dir;
    Hive.registerAdapter(StackModelHiveAdapter());

    Hive.init(dir.path);
    config = await Hive.openBox('config');
    stack = await Hive.openBox('stack');
    scanSnap = await Hive.openBox('scan_snap');
    printHiveData(stack);
    printHiveData(scanSnap);
  }

  // config

  bool get isFirstRun => config.get('is_first_run') ?? true;
  set isFirstRun(bool value) => config.put('is_first_run', value);

  // scansnap
  int? get paperSize => scanSnap.get('paper_size');
  int? get formatFile => scanSnap.get('format_file');
  int? get colorMode => scanSnap.get('color_mode');
  int? get compression => scanSnap.get('compression');
  int? get imageQuality => scanSnap.get('image_quality');
  int? get scanSide => scanSnap.get('scan_side');
  int? get blankRemove => scanSnap.get('blank_remove');
  int? get brightness => scanSnap.get('brightness');
  int? get multiFeed => scanSnap.get('multi_feed');
  int? get bleedThrough => scanSnap.get('bleed_through');
  int? get eDocMode => scanSnap.get('e_doc_mode');
  int? get feedMode => scanSnap.get('feed_mode');
  int? get paperProtection => scanSnap.get('paper_protection');

  set paperSize(int? value) => scanSnap.put('paper_size', value);
  set formatFile(int? value) => scanSnap.put('format_file', value);
  set colorMode(int? value) => scanSnap.put('color_mode', value);
  set compression(int? value) => scanSnap.put('compression', value);
  set imageQuality(int? value) => scanSnap.put('image_quality', value);
  set scanSide(int? value) => scanSnap.put('scan_side', value);
  set blankRemove(int? value) => scanSnap.put('blank_remove', value);
  set brightness(int? value) => scanSnap.put('brightness', value);
  set multiFeed(int? value) => scanSnap.put('multi_feed', value);
  set bleedThrough(int? value) => scanSnap.put('bleed_through', value);
  set eDocMode(int? value) => scanSnap.put('e_doc_mode', value);
  set feedMode(int? value) => scanSnap.put('feed_mode', value);
  set paperProtection(int? value) => scanSnap.put('paper_protection', value);

  void removeStack() => stack.clear();
  void removeScanSnap() => scanSnap.clear();

  clearLocalData() {
    removeStack();
    removeScanSnap();
  }

  initializeStack() {
    if (stack.values.toList().isNotEmpty) {
      return;
    } else {
      for (var stackModel in listStackModel) {
        stack.put(stackModel.address, stackModel);
      }
    }
  }

  void changeStackModel(dynamic key, StackModelHive stackModel) {
    stack.put(key, stackModel);
  }
}

printHiveData(Box box) {
  if (box is Box<StackModelHive>) {
    print("==================${box.name}==================");
    print("\n");
    print("\n");

    for (var element in box.keys.toList()) {
      print("$element   :   ${box.get(element)?.merge}\n");
    }
    print("\n");
  } else {
    print("==================${box.name}==================");
    print("\n");
    print("\n");

    for (var element in box.keys.toList()) {
      print("key: $element      value: ${box.get(element)}\n");
    }
    print("\n");
  }
}
