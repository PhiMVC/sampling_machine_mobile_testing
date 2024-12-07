import 'dart:async';
import 'package:sampling_machine_mobile_testing/data/channel/app_platform_channel.dart';
import 'package:sampling_machine_mobile_testing/data/machine_api/machine_api_interface.dart';

String convertIntToStringRadix16(
    int d1Base, int d2Base, int d3Base, int d4Base, int d5Base, int d6Base) {
  late String d1, d2, d3, d4, d5, d6;
  if (d1Base.toRadixString(16).length < 2) {
    d1 = "0${d1Base..toRadixString(16)}";
  } else {
    d1 = d1Base.toRadixString(16);
  }
  if (d2Base.toRadixString(16).length < 2) {
    d2 = "0${d2Base.toRadixString(16)}";
  } else {
    d2 = d2Base.toRadixString(16);
  }
  if (d3Base.toRadixString(16).length < 2) {
    d3 = "0${d3Base.toRadixString(16)}";
  } else {
    d3 = d3Base.toRadixString(16);
  }
  if (d4Base.toRadixString(16).length < 2) {
    d4 = "0${d4Base.toRadixString(16)}";
  } else {
    d4 = d4Base.toRadixString(16);
  }
  if (d5Base.toRadixString(16).length < 2) {
    d5 = "0${d5Base.toRadixString(16)}";
  } else {
    d5 = d5Base.toRadixString(16);
  }
  if (d6Base.toRadixString(16).length < 2) {
    d6 = "0${d6Base.toRadixString(16)}";
  } else {
    d6 = d6Base.toRadixString(16);
  }

  return "$d1$d2$d3$d4$d5$d6";
}

class MachineApiImp implements MachineApiInterface {
  MachineApiImp();
  static const int d1 = 0x00;
  static const int d2 = 0xFF;

  @override
  Future<void> requestGiveGiftTurnOnSensor(int d3) async {
    int d4 = 0xFF - d3;

    /// turn on sensor
    int d5 = 0xAA;
    int d6 = 0x55;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  @override
  Future<void> requestGiveGiftTurnOffSensor(int d3) async {
    int d4 = 0xFF - d3;

    /// turn off sensor
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  @override
  Future<void> requestCheckSensor() async {
    /// check sensor
    int d3 = 0x64;
    int d4 = 0xFF - d3;
    int d5 = 0xAA;
    int d6 = 0x55;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  @override
  Future<void> requestNoCheckSensor() async {
    /// check sensor
    int d3 = 0x64;
    int d4 = 0xFF - d3;
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// Always response: 0X00 0X5D 0X00 0X00 0X5D
  @override
  Future<void> resetRootPosition() async {
    /// delete engine failure
    int d3 = 0x65;
    int d4 = 0xFF - d3;
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// Just call one time
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  ///
  /// if config failure, call until success
  @override
  Future<void> configStacks() async {
    //Uint8List listValue = Uint8List.fromList([0X00, 0XFF, 0X75, 0X8A, 0X55, 0XAA]);
    int d3 = 0X75;
    int d4 = 0X8A;
    int d5 = 0X55;
    int d6 = 0XAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xCA
  ///
  /// d5 is first stack on the both need combine
  ///
  /// address of stack after combine is the first stack address
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  @override
  Future<void> combineStack(int d5) async {
    int d3 = 0xCA;
    int d4 = 0xFF - d3;
    int d6 = 0xFF - d5;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xC9
  ///
  /// d5 address stack need separate
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  @override
  Future<void> separateOneStack(int d5) async {
    int d3 = 0xC9;
    int d4 = 0xFF - d3;
    int d6 = 0xFF - d5;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xCB
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  @override
  Future<void> separateAllStacks() async {
    int d3 = 0xCB;
    int d4 = 0xFF - d3;
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xDD
  @override
  Future<void> turnOnLed() async {
    int d3 = 0xDD;
    int d4 = 0xFF - d3;
    int d5 = 0xAA;
    int d6 = 0x55;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xDD
  @override
  Future<void> turnOffLed() async {
    int d3 = 0xDD;
    int d4 = 0xFF - d3;
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  /// d3 must be 0xDF
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: close
  ///
  /// 0X00 0X5C 0X00 0X00 0X5E: open
  @override
  Future<void> readState() async {
    int d3 = 0xDF;
    int d4 = 0xFF - d3;
    int d5 = 0x55;
    int d6 = 0xAA;

    final argument = convertIntToStringRadix16(d1, d2, d3, d4, d5, d6);
    await writeChannel.invokeMethod('write', argument);
  }

  StreamSubscription? readSubscription;

  /// The stream connect flutter and android
  @override
  void registReceiver(Function(String value) callback) {
    readSubscription = readChannel.receiveBroadcastStream().listen((event) {
      callback(event);
    });
  }

  @override
  void cancelReceiver() {
    readSubscription?.cancel();
    readSubscription = null;
  }
}
