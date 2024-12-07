import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sampling_machine_mobile_testing/data/channel/app_platform_channel.dart';
import 'package:sampling_machine_mobile_testing/data/scan_bill_api/scan_bill_interface.dart';

class ScanBillEmp implements ScanBillInterface {
  ScanBillEmp();
  StreamSubscription? readSubscription;

  @override
  StreamSubscription<dynamic> registReceiver(Function(dynamic value) callback) {
    return scanChannel.receiveBroadcastStream().listen((value) {
      callback(value);
    });
  }

  @override
  void cancelReceiver() {
    readSubscription?.cancel();
    readSubscription = null;
  }

  @override
  Future<bool> startScanSession() async {
    bool res = await writeChannel.invokeMethod("startScanSession");
    return res;
  }

  @override
  Future<bool> setBlankRemove(int blankRemove) async {
    bool res = await writeChannel.invokeMethod("setBlankRemove", blankRemove);
    return res;
  }

  @override
  Future<bool> setBleedThrough(int bleedThrough) async {
    bool res = await writeChannel.invokeMethod("setBleedThrough", bleedThrough);
    return res;
  }

  @override
  Future<bool> setBrightness(int brightness) async {
    bool res = await writeChannel.invokeMethod("setBrightness", brightness);
    return res;
  }

  @override
  Future<bool> setColorMode(int colorMode) async {
    bool res = await writeChannel.invokeMethod("setColorMode", colorMode);
    return res;
  }

  @override
  Future<bool> setCompression(int compressionLevel) async {
    bool res =
        await writeChannel.invokeMethod("setCompression", compressionLevel);
    return res;
  }

  @override
  Future<bool> setEDocMode(int eDocMode) async {
    bool res = await writeChannel.invokeMethod("setEDocMode", eDocMode);
    return res;
  }

  @override
  Future<bool> setFeedMode(int feedMode) async {
    bool res = await writeChannel.invokeMethod("setFeedMode", feedMode);
    return res;
  }

  @override
  Future<bool> setFileFormat(int fileFormatOption) async {
    bool res =
        await writeChannel.invokeMethod("setFileFormat", fileFormatOption);
    return res;
  }

  @override
  Future<bool> setImageQuality(int imageQuality) async {
    bool res = await writeChannel.invokeMethod("setImageQuality", imageQuality);
    return res;
  }

  @override
  Future<bool> setMultiFeed(int multiFeed) async {
    bool res = await writeChannel.invokeMethod("setMultiFeed", multiFeed);
    return res;
  }

  @override
  Future<bool> setOutputPath(String path) async {
    bool res = await writeChannel.invokeMethod("setOutputPath", path);
    return res;
  }

  @override
  Future<bool> setPaperProtection(int paperProtection) async {
    bool res =
        await writeChannel.invokeMethod("setPaperProtection", paperProtection);
    return res;
  }

  @override
  Future<bool> setPaperSize(int paperSize) async {
    bool res = await writeChannel.invokeMethod("setPaperSize", paperSize);
    return res;
  }

  @override
  Future<bool> setScanSide(int scanSide) async {
    bool res = await writeChannel.invokeMethod("setScanSide", scanSide);
    return res;
  }

  @override
  Future<int> getBlankRemove() async {
    int res = await writeChannel.invokeMethod("getBlankRemove");
    return res;
  }

  @override
  Future<int> getBleedThrough() async {
    int res = await writeChannel.invokeMethod("getBleedThrough");
    return res;
  }

  @override
  Future<int> getBrightness() async {
    int res = await writeChannel.invokeMethod("getBrightness");
    return res;
  }

  @override
  Future<int> getColorMode() async {
    int res = await writeChannel.invokeMethod("getColorMode");
    return res;
  }

  @override
  Future<int> getCompression() async {
    int res = await writeChannel.invokeMethod("getCompression");
    return res;
  }

  @override
  Future<int> getEDocMode() async {
    int res = await writeChannel.invokeMethod("getEDocMode");
    return res;
  }

  @override
  Future<int> getFeedMode() async {
    int res = await writeChannel.invokeMethod("getFeedMode");
    return res;
  }

  @override
  Future<int> getFileFormat() async {
    int res = await writeChannel.invokeMethod("getFileFormat");
    return res;
  }

  @override
  Future<int> getImageQuality() async {
    int res = await writeChannel.invokeMethod("getImageQuality");
    return res;
  }

  @override
  Future<int> getMultiFeed() async {
    int res = await writeChannel.invokeMethod("getMultiFeed");
    return res;
  }

  @override
  Future<String> getOutputPath() async {
    String res = await writeChannel.invokeMethod("getOutputPath");
    return res;
  }

  @override
  Future<int> getPaperProtection() async {
    int res = await writeChannel.invokeMethod("getPaperProtection");
    return res;
  }

  @override
  Future<int> getPaperSize() async {
    int res = await writeChannel.invokeMethod("getPaperSize");
    return res;
  }

  @override
  Future<String> getPassword() async {
    String res = await writeChannel.invokeMethod("getPassword");
    return res;
  }

  @override
  Future<int> getScanSide() async {
    int res = await writeChannel.invokeMethod("getScanSide");
    return res;
  }
}
