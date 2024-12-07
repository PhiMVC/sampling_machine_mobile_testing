abstract class MachineResponseState {
  String get message;
  MachineResponseState();
}

/*------------------------------------ SPECIAL STATE ------------------------------------*/
abstract class SpecialState extends MachineResponseState {}

class SuccesState extends SpecialState {
  @override
  String get message => "Thành công";
  SuccesState();
}

class DoorOpen extends SpecialState {
  @override
  String get message => "Cửa mở";
  DoorOpen();
}

class DoorClose extends SpecialState {
  @override
  String get message => "Cửa đóng";
  DoorClose();
}

class ResetRootPositionSuccess extends SpecialState {
  @override
  String get message => "Reset vị trí gốc thành công";
  ResetRootPositionSuccess();
}

class ConnectDriverSuccess extends SpecialState {
  @override
  String get message => "Kết nối với Driver thành công";
  ConnectDriverSuccess();
}

class ConnectDriverFail extends SpecialState {
  @override
  String get message => "Kết nối với Driver thất bại";
  ConnectDriverFail();
}

class ConfigStackToSpringSuccess extends SpecialState {
  @override
  String get message => "Cấu hình ngăn hàng sang chế độ lò xo thành công";
  ConfigStackToSpringSuccess();
}

class ConfigStackToSpringFail extends SpecialState {
  @override
  String get message => "Cấu hình ngăn hàng sang chế độ lò xo thất bại";
  ConfigStackToSpringFail();
}

class CombineOrSeparateSuccess extends SpecialState {
  @override
  String get message => "Gộp/Tách ngăn thành công";
  CombineOrSeparateSuccess();
}

class CombineOrSeparateFail extends SpecialState {
  @override
  String get message => "Gộp/Tách ngăn thất bại";
  CombineOrSeparateFail();
}

/*------------------------------------ PUSH SAMPLING STATE ------------------------------------*/
abstract class PushSampingState extends MachineResponseState {}

class PMOSError extends PushSampingState {
  @override
  String get message => "PMOS ngắn mạch";
  PMOSError();
}

class NMOSError extends PushSampingState {
  @override
  String get message => "NMOS ngắn mạch";
  NMOSError();
}

class EngineBreakCircuitError extends PushSampingState {
  @override
  String get message => "Động cơ ngắn mạch";
  EngineBreakCircuitError();
}

class EngineOpenCircuitError extends PushSampingState {
  @override
  String get message => "Động cơ bị hở mạch";
  EngineOpenCircuitError();
}

class EngineWorkTimeoutError extends PushSampingState {
  @override
  String get message =>
      "Động cơ quay quá thời gian (Lỗi công tắc hành trình sau động cơ)";
  EngineWorkTimeoutError();
}

class SensorError extends PushSampingState {
  @override
  String get message => "Cảm biến rơi bị lỗi";
  SensorError();
}

class SensorTurnOffOrHardwareError extends PushSampingState {
  @override
  String get message => "Cảm biến rơi bị tắt hoặc lỗi phần cứng";
  SensorTurnOffOrHardwareError();
}

class SensorSuccessfulDetectWithOneRound extends PushSampingState {
  @override
  String get message => "Cảm biến rơi phát hiện sampling thành công";
  SensorSuccessfulDetectWithOneRound();
}

class SensorSuccessfulDetectWithAdditionRound extends PushSampingState {
  @override
  String get message => "Cảm biến rơi phát hiện sampling thành công";
  SensorSuccessfulDetectWithAdditionRound();
}

class SensorNoDetectWithNoError extends PushSampingState {
  @override
  String get message => "Cảm biến rơi không phát hiện sampling";
  SensorNoDetectWithNoError();
}

class MachineNotWork extends PushSampingState {
  @override
  String get message => "Có lỗi xảy ra, liên hệ admin";
  MachineNotWork();
}

class CombineOrSeparateError extends PushSampingState {
  @override
  String get message => "Gộp ngăn hoặc tách ngăn lỗi";
  CombineOrSeparateError();
}
