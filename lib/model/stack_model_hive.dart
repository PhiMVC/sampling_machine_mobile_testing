import 'package:hive_flutter/hive_flutter.dart';

part 'stack_model_hive.g.dart';

@HiveType(typeId: 0)
class StackModelHive extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int address;
  @HiveField(2)
  bool merge;

  StackModelHive(this.name, this.address, {this.merge = false});
}
