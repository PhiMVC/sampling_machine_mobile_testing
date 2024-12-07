import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_interface.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

class ScanBillService {
  late ScanBillInterface _scanBillInterface;
  final sharedPrefs = locator<SharedPrefs>();
  ScanBillService() {
    _scanBillInterface = ScanBillInterface();
  }

  StreamSubscription<dynamic> registReceiver(Function(dynamic value) callback) {
    final res = _scanBillInterface.registReceiver(callback);
    return res;
  }

  void cancelReceiver() => _scanBillInterface.cancelReceiver();

  Future<bool> startScanSession() async {
    final res = await _scanBillInterface.startScanSession();
    return res;
  }

  Future<bool> setBlankRemove(int blankRemove) async {
    final res = await _scanBillInterface.setBlankRemove(blankRemove);
    if (res) {
      sharedPrefs.blankRemove = blankRemove;
    }
    return res;
  }

  Future<bool> setBleedThrough(int bleedThrough) async {
    final res = await _scanBillInterface.setBleedThrough(bleedThrough);
    if (res) {
      sharedPrefs.bleedThrough = bleedThrough;
    }
    return res;
  }

  Future<bool> setBrightness(int brightness) async {
    final res = await _scanBillInterface.setBrightness(brightness);
    if (res) {
      sharedPrefs.brightness = brightness;
    }
    return res;
  }

  Future<bool> setColorMode(int colorMode) async {
    final res = await _scanBillInterface.setColorMode(colorMode);
    if (res) {
      sharedPrefs.colorMode = colorMode;
    }
    return res;
  }

  Future<bool> setCompression(int compressionLevel) async {
    final res = await _scanBillInterface.setCompression(compressionLevel);
    if (res) {
      sharedPrefs.compression = compressionLevel;
    }
    return res;
  }

  Future<bool> setEDocMode(int eDocMode) async {
    final res = await _scanBillInterface.setEDocMode(eDocMode);
    if (res) {
      sharedPrefs.eDocMode = eDocMode;
    }
    return res;
  }

  Future<bool> setFeedMode(int feedMode) async {
    final res = await _scanBillInterface.setFeedMode(feedMode);
    if (res) {
      sharedPrefs.feedMode = feedMode;
    }
    return res;
  }

  Future<bool> setFileFormat(int fileFormatOption) async {
    final res = await _scanBillInterface.setFileFormat(fileFormatOption);
    if (res) {
      sharedPrefs.formatFile = fileFormatOption;
    }
    return res;
  }

  Future<bool> setImageQuality(int imageQuality) async {
    final res = await _scanBillInterface.setImageQuality(imageQuality);
    if (res) {
      sharedPrefs.imageQuality = imageQuality;
    }
    return res;
  }

  Future<bool> setMultiFeed(int multiFeed) async {
    final res = await _scanBillInterface.setMultiFeed(multiFeed);
    if (res) {
      sharedPrefs.multiFeed = multiFeed;
    }
    return res;
  }

  Future<bool> setOutputPath(String path) async {
    final res = await _scanBillInterface.setOutputPath(path);
    return res;
  }

  Future<bool> setPaperProtection(int paperProtection) async {
    final res = await _scanBillInterface.setPaperProtection(paperProtection);
    if (res) {
      sharedPrefs.paperProtection = paperProtection;
    }
    return res;
  }

  Future<bool> setPaperSize(int paperSize) async {
    final res = await _scanBillInterface.setPaperSize(paperSize);
    if (res) {
      sharedPrefs.paperSize = paperSize;
    }
    return res;
  }

  Future<bool> setScanSide(int scanSide) async {
    final res = await _scanBillInterface.setScanSide(scanSide);
    if (res) {
      sharedPrefs.scanSide = scanSide;
    }
    return res;
  }

  Future<int> getBlankRemove() async {
    int res = await _scanBillInterface.getBlankRemove();
    return res;
  }

  Future<int> getBleedThrough() async {
    int res = await _scanBillInterface.getBleedThrough();
    return res;
  }

  Future<int> getBrightness() async {
    int res = await _scanBillInterface.getBrightness();
    return res;
  }

  Future<int> getColorMode() async {
    int res = await _scanBillInterface.getColorMode();
    return res;
  }

  Future<int> getCompression() async {
    int res = await _scanBillInterface.getCompression();
    return res;
  }

  Future<int> getEDocMode() async {
    int res = await _scanBillInterface.getEDocMode();
    return res;
  }

  Future<int> getFeedMode() async {
    int res = await _scanBillInterface.getFeedMode();
    return res;
  }

  Future<int> getFileFormat() async {
    int res = await _scanBillInterface.getFileFormat();
    return res;
  }

  Future<int> getImageQuality() async {
    int res = await _scanBillInterface.getImageQuality();
    return res;
  }

  Future<int> getMultiFeed() async {
    int res = await _scanBillInterface.getMultiFeed();
    return res;
  }

  Future<String> getOutputPath() async {
    String res = await _scanBillInterface.getOutputPath();
    return res;
  }

  Future<int> getPaperProtection() async {
    int res = await _scanBillInterface.getPaperProtection();
    return res;
  }

  Future<int> getPaperSize() async {
    int res = await _scanBillInterface.getPaperSize();
    return res;
  }

  Future<String> getPassword() async {
    String res = await _scanBillInterface.getPassword();
    return res;
  }

  Future<int> getScanSide() async {
    int res = await _scanBillInterface.getScanSide();
    return res;
  }
}
