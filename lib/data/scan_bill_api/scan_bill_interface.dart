import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_imp.dart';

abstract class ScanBillInterface {
  factory ScanBillInterface() = ScanBillEmp;

  Future<bool> startScanSession();

  Future<bool> setOutputPath(String path);

  Future<bool> setFileFormat(int fileFormatOption);

  Future<bool> setImageQuality(int imageQuality);

  Future<bool> setColorMode(int colorMode);

  Future<bool> setCompression(int compressionLevel);

  Future<bool> setScanSide(int scanSide);

  Future<bool> setPaperSize(int paperSize);

  Future<bool> setBlankRemove(int blankRemove);

  Future<bool> setMultiFeed(int multiFeed);

  Future<bool> setBleedThrough(int bleedThrough);

  Future<bool> setEDocMode(int eDocMode);

  Future<bool> setFeedMode(int feedMode);

  Future<bool> setPaperProtection(int paperProtection);

  Future<bool> setBrightness(int brightness);

  StreamSubscription<dynamic> registReceiver(Function(dynamic value) callback);

  void cancelReceiver();

  Future<String> getPassword();

  Future<String> getOutputPath();

  Future<int> getFileFormat();

  Future<int> getImageQuality();

  Future<int> getColorMode();

  Future<int> getCompression();

  Future<int> getScanSide();

  Future<int> getPaperSize();

  Future<int> getBlankRemove();

  Future<int> getMultiFeed();

  Future<int> getBleedThrough();

  Future<int> getEDocMode();

  Future<int> getFeedMode();

  Future<int> getPaperProtection();

  Future<int> getBrightness();
}
