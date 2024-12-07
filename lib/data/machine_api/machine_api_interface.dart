import 'dart:async';
import 'machine_api_imp.dart';

abstract class MachineApiInterface {
  factory MachineApiInterface() = MachineApiImp;

  Future<void> requestGiveGiftTurnOnSensor(int d3);

  Future<void> requestGiveGiftTurnOffSensor(int d3);

  Future<void> requestCheckSensor();

  Future<void> requestNoCheckSensor();

  /// Always response: 0X00 0X5D 0X00 0X00 0X5D
  Future<void> resetRootPosition();

  /// Just call one time
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  ///
  /// if config failure, call until success
  Future<void> configStacks();

  /// d3 must be 0xCA
  ///
  /// d5 is first stack on the both need combine
  ///
  /// address of stack after combine is the first stack address
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  Future<void> combineStack(int d5);

  /// d3 must be 0xC9
  ///
  /// d5 address stack need separate
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  Future<void> separateOneStack(int d5);

  /// d3 must be 0xCB
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: config success
  ///
  /// 0X00 0X5C 0X00 0X00 0X5C: config failure
  Future<void> separateAllStacks();

  /// d3 must be 0xDD
  Future<void> turnOnLed();

  /// d3 must be 0xDD
  Future<void> turnOffLed();

  /// d3 must be 0xDF
  ///
  /// 0X00 0X5D 0X00 0X00 0X5D: close
  ///
  /// 0X00 0X5C 0X00 0X00 0X5E: open
  Future<void> readState();

  /// The stream connect flutter and android

  void registReceiver(Function(String value) callback);

  void cancelReceiver();
}
