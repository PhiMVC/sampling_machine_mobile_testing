import 'package:sampling_machine_mobile_testing/data/machine_api/model/machine_response_state.dart';
import 'package:sampling_machine_mobile_testing/utils/uint8_list_utils.dart';

String success =
    "00 5d 00 00 5d"; // Cấu hình thành công, Cửa mở, gộp-tách ngăn thành công

String fail = "00 5c 00 00 5c"; // Cấu hình thất bại, gộp-tách ngăn thất bại

String doorClose = "00 5d 01 00 5e"; // Cửa đóng

String connectToDriverFail = "ff ff ff ff ff";

String connectToDriverSuccess = "00 00 00 00 00";

class MachineResponseData {
  final String data;
  MachineResponseData({required this.data});

  List<int> get listData =>
      data.split(" ").map((e) => int.parse(e, radix: 16)).toList();
  List<MachineResponseState> get dropSamplingState {
    List<MachineResponseState> listResult = [];

    /// R3

    if (listData[2].toRadixString(16).runes.last != 0) {
      listResult.add(SensorError());
    }
    if (listData[2] > 0x10 && listData[2] <= 0x1f) {
      listResult.add(PMOSError());
    }
    if (listData[2] > 0x20 && listData[2] <= 0x2f) {
      listResult.add(NMOSError());
    }
    if (listData[2] > 0x30 && listData[2] <= 0x3f) {
      listResult.add(EngineBreakCircuitError());
    }
    if (listData[2] > 0x40 && listData[2] <= 0x4f) {
      listResult.add(EngineOpenCircuitError());
    }
    if (listData[2] > 0x50 && listData[2] <= 0x5f) {
      listResult.add(EngineWorkTimeoutError());
    }

    /// R4
    if (listData[3] == 0x00) {
      listResult.add(SensorTurnOffOrHardwareError());
    }
    if (listData[3] == 0xAA) {
      listResult.add(SensorSuccessfulDetectWithOneRound());
    }
    if (listData[3] == 0xCC) {
      listResult.add(SensorSuccessfulDetectWithAdditionRound());
    }
    if (listData[3] == 0x33) {
      listResult.add(SensorNoDetectWithNoError());
    }

    return listResult;
  }

  MachineResponseState? get configState {
    if (Uint8ListUtils.compare(data, success)) {
      return SuccesState();
    }
    return null;
  }

  /// cause 3 case: device not found, driver not found, permission denied
  MachineResponseState? get connectionState {
    if (Uint8ListUtils.compare(data, connectToDriverSuccess)) {
      return ConnectDriverSuccess();
    }
    if (Uint8ListUtils.compare(data, connectToDriverFail)) {
      return ConnectDriverFail();
    }
    return null;
  }

  MachineResponseState? get doorState {
    if (Uint8ListUtils.compare(data, doorClose)) {
      return DoorClose();
    }
    if (Uint8ListUtils.compare(data, success)) {
      return DoorOpen();
    }
    return null;
  }

  // Message
  String get dropSamplingMessage {
    String res = "";
    if (dropSamplingState.length == 1) {
      res = dropSamplingState.first.message;
    } else {
      for (var element in dropSamplingState) {
        res = "$res\n${element.message}";
      }
    }

    return res;
  }
}
