import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_service.dart';
import 'package:sampling_machine_mobile_testing/global.dart';
import 'package:sampling_machine_mobile_testing/model/stack_model_hive.dart';
import 'package:sampling_machine_mobile_testing/data/machine_api/machine_api_service.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

import '../../data/machine_api/model/machine_response_data.dart';

class SettingProvider extends ChangeNotifier with ReceiveDataFromMachine {
  List<int> stackPush = [];
  List<StackModelHive> stacks = [];
  MachineResponseData? currentMachineResponse;
  MachineApiService machineApiService = locator<MachineApiService>();
  ScanBillService scanBillApiService = locator<ScanBillService>();

  SharedPrefs sharedPrefs = locator<SharedPrefs>();

  SettingProvider() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await onInit();
    });
  }

  onInit() async {
    sharedPrefs.initializeStack();
    machineApiService.registReceiver(
        (value) => onReceiveDataFromMachine(MachineResponseData(data: value)));
    stacks = List.from(sharedPrefs.stack.values.toList());
    for (int i = 1; i < 61; i++) {
      if (i != 9 &&
          i != 10 &&
          i != 19 &&
          i != 20 &&
          i != 29 &&
          i != 30 &&
          i != 39 &&
          i != 40 &&
          i != 49 &&
          i != 50 &&
          i != 59 &&
          i != 60) {
        stackPush.add(i);
      }
    }
    notifyListeners();
  }

  @override
  dispose() {
    try {
      machineApiService.cancelReceiver();
    } catch (e) {
      print("Error when cancel stream of event channel $e");
    }
    return super.dispose();
  }

  // machine

  Future<void> requestGiveGiftTurnOnSensor(int d3) async {
    return await machineApiService.requestGiveGiftTurnOnSensor(d3);
  }

  Future<void> requestGiveGiftTurnOffSensor(int d3) async {
    return await machineApiService.requestGiveGiftTurnOffSensor(d3);
  }

  Future<void> resetRootPosition() async {
    return await machineApiService.resetRootPosition();
  }

  Future<void> requestCheckSensor() async {
    return await machineApiService.requestCheckSensor();
  }

  Future<void> requestNoCheckSensor() async {
    return await machineApiService.requestNoCheckSensor();
  }

  Future<void> configStacks() async {
    return await machineApiService.configStacks();
  }

  Future<void> combineStack(int d5) async {
    return await machineApiService.combineStack(d5);
  }

  Future<void> separateOneStack(int d5) async {
    return await machineApiService.separateOneStack(d5);
  }

  Future<void> separateAllStacks() async {
    return await machineApiService.separateAllStacks();
  }

  Future<void> turnOnLed() async {
    return await machineApiService.turnOnLed();
  }

  Future<void> turnOffLed() async {
    return await machineApiService.turnOffLed();
  }

  Future<void> readState() async {
    return await machineApiService.readState();
  }

  Future<bool> setPaperSize(int value) async =>
      await scanBillApiService.setPaperSize(value);
  Future<bool> setFormatFile(int value) async =>
      await scanBillApiService.setFileFormat(value);
  Future<bool> setColorMode(int value) async =>
      await scanBillApiService.setColorMode(value);
  Future<bool> setCompression(int value) async =>
      await scanBillApiService.setCompression(value);
  Future<bool> setImageQuality(int value) async =>
      await scanBillApiService.setImageQuality(value);
  Future<bool> setScanSide(int value) async =>
      await scanBillApiService.setScanSide(value);
  Future<bool> setBlankRemove(int value) async =>
      await scanBillApiService.setBlankRemove(value);
  Future<bool> setBrightness(int value) async =>
      await scanBillApiService.setBrightness(value);
  Future<bool> setMultiFeed(int value) async =>
      await scanBillApiService.setMultiFeed(value);
  Future<bool> setBleedThrough(int value) async =>
      await scanBillApiService.setBleedThrough(value);
  Future<bool> setEDocMode(int value) async =>
      await scanBillApiService.setEDocMode(value);
  Future<bool> setFeedMode(int value) async =>
      await scanBillApiService.setFeedMode(value);
  Future<bool> setPaperProtection(int value) async =>
      await scanBillApiService.setPaperProtection(value);

  rebuild() => notifyListeners();

  @override
  onReceiveDataFromMachine(MachineResponseData data) {
    currentMachineResponse = data;
    if (navigatorKey.currentContext != null && currentMachineResponse != null) {
      if (currentMachineResponse!.configState != null) {
        showDialog(
            context: navigatorKey.currentContext!,
            builder: (c) {
              return AlertDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          navigatorKey.currentState?.pop();
                        },
                        child: const Text("Ok"))
                  ],
                  content: Text(
                      currentMachineResponse!.configState!.message.toString()));
            });
      }
    }
  }

  Future<void> checkAndUpdate() async {
    AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();
    if (appUpdateInfo.updateAvailability ==
        UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate();
    }
  }
}

mixin ReceiveDataFromMachine implements ChangeNotifier {
  onReceiveDataFromMachine(MachineResponseData data);
}
