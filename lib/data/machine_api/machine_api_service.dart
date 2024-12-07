import 'dart:async';
import 'package:sampling_machine_mobile_testing/data/machine_api/machine_api_interface.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

class MachineApiService {
  MachineApiService() {
    machineApi = MachineApiInterface();
    bool isFirstRun = locator<SharedPrefs>().isFirstRun;
    if (isFirstRun) {
      separateAllStacks();
      locator<SharedPrefs>().isFirstRun = false;
    }
  }
  late MachineApiInterface machineApi;

  Future<void> requestGiveGiftTurnOnSensor(int d3) async =>
      await machineApi.requestGiveGiftTurnOnSensor(d3);

  Future<void> requestGiveGiftTurnOffSensor(int d3) async =>
      await machineApi.requestGiveGiftTurnOffSensor(d3);

  Future<void> requestCheckSensor() async =>
      await machineApi.requestCheckSensor();

  Future<void> requestNoCheckSensor() async =>
      await machineApi.requestNoCheckSensor();

  /// Always response: 0X00 0X5D 0X00 0X00 0X5D

  Future<void> resetRootPosition() async =>
      await machineApi.resetRootPosition();

  /// Just call one time
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  ///
  /// if config failure, call until success

  Future<void> configStacks() async => await machineApi.configStacks();

  /// d3 must be 0xCA
  ///
  /// d5 is first stack on the both need combine
  ///
  /// address of stack after combine is the first stack address
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure

  Future<void> combineStack(int d5) async => await machineApi.combineStack(d5);

  /// d3 must be 0xC9
  ///
  /// d5 address stack need separate
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure

  Future<void> separateOneStack(int d5) async =>
      await machineApi.separateOneStack(d5);

  /// d3 must be 0xCB
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure

  Future<void> separateAllStacks() async =>
      await machineApi.separateAllStacks();

  /// d3 must be 0xDD

  Future<void> turnOnLed() async => await machineApi.turnOnLed();

  /// d3 must be 0xDD

  Future<void> turnOffLed() async => await machineApi.turnOffLed();

  /// d3 must be 0xDF
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: open
  ///
  /// 0X00 0X5C 0X00 0X00 0X5E: close

  Future<void> readState() async => await machineApi.readState();

  /// The stream connect flutter and android

  void registReceiver(Function(String value) callback) =>
      machineApi.registReceiver(callback);

  /// The stream connect flutter and android

  void cancelReceiver() => machineApi.cancelReceiver();
}
