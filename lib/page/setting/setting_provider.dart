import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sampling_machine_mobile_testing/data/machine_api/model/machine_response_state.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_service.dart';
import 'package:sampling_machine_mobile_testing/global.dart';
import 'package:sampling_machine_mobile_testing/model/stack_model_hive.dart';
import 'package:sampling_machine_mobile_testing/data/machine_api/machine_api_service.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

import '../../data/machine_api/model/machine_response_data.dart';

enum RequestType { normal, drop, readDoorState, separateAllStacks }

class SettingProvider extends ChangeNotifier with ReceiveDataFromMachine {
  RequestType? requestType;

  bool isLoading = false;

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

  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
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
    showLoading();
    requestType = RequestType.drop;
    return await machineApiService.requestGiveGiftTurnOnSensor(d3);
  }

  Future<void> resetRootPosition() async {
    showLoading();
    requestType = RequestType.normal;
    return await machineApiService.resetRootPosition();
  }

  Future<void> initConfigStacks() async {
    showLoading();
    requestType = RequestType.normal;
    return await machineApiService.configStacks();
  }

  Future<void> combineStack(int d5) async {
    showLoading();
    requestType = RequestType.normal;
    return await machineApiService.combineStack(d5);
  }

  Future<void> separateOneStack(int d5) async {
    showLoading();
    requestType = RequestType.normal;
    return await machineApiService.separateOneStack(d5);
  }

  Future<void> separateAllStacks() async {
    showLoading();
    requestType = RequestType.separateAllStacks;
    return await machineApiService.separateAllStacks();
  }

  Future<void> readState() async {
    showLoading();
    requestType = RequestType.readDoorState;
    return await machineApiService.readState();
  }

  @override
  onReceiveDataFromMachine(MachineResponseData data) {
    hideLoading();
    currentMachineResponse = data;
    if (navigatorKey.currentContext != null && currentMachineResponse != null) {
      if (requestType != null) {
        switch (requestType) {
          case RequestType.separateAllStacks:
            if (currentMachineResponse?.data == "00 5d 00 00 5d") {
              for (var value in sharedPrefs.stack.values
                  .where((element) => element.merge == true)) {
                value.merge = false;
                sharedPrefs.changeStackModel(value.key, value);
              }
              notifyListeners();
              showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (c) {
                    return AlertDialog(actions: [
                      ElevatedButton(
                          onPressed: () {
                            navigatorKey.currentState?.pop();
                          },
                          child: const Text("Ok"))
                    ], content: const Text("Thành Công"));
                  });
            } else {
              showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (c) {
                    return AlertDialog(actions: [
                      ElevatedButton(
                          onPressed: () {
                            navigatorKey.currentState?.pop();
                          },
                          child: const Text("Ok"))
                    ], content: const Text("Thất bại"));
                  });
            }
            break;

          case RequestType.drop:
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
                      content: Text(currentMachineResponse!.dropSamplingState
                              .where((element) =>
                                  element
                                      is SensorSuccessfulDetectWithOneRound ||
                                  element
                                      is SensorSuccessfulDetectWithAdditionRound)
                              .isNotEmpty
                          ? "Thành công"
                          : "Thất bại"));
                });
            break;
          case RequestType.normal:
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
                          currentMachineResponse?.data == '00 5d 00 00 5d'
                              ? "Thành Công"
                              : "Thất bại"));
                });

            break;
          case RequestType.readDoorState:
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
                      content:
                          Text(currentMachineResponse?.data == '00 5d 01 00 5e'
                              ? "Cửa đóng"
                              : currentMachineResponse?.data == '00 5d 00 00 5d'
                                  ? "Cửa mở"
                                  : "Lỗi không xác định"));
                });
            break;
          default:
        }
      } else {
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
                  content: Text(currentMachineResponse?.data == "00 5d 00 00 5d"
                      ? "Kết nối RS232 thành công"
                      : "Kết nối RS232 thất bại"));
            });
      }
    }
    requestType = null;
  }
}

mixin ReceiveDataFromMachine implements ChangeNotifier {
  onReceiveDataFromMachine(MachineResponseData data);
}
