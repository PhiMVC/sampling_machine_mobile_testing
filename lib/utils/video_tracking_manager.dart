import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoTrackingManager {
  VideoTrackingManager() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialize();
    });
  }
  List<CameraDescription> listDesciption = [];
  CameraController? controller;
  bool isInitialize = false;

  Future initialize() async {
    listDesciption = await availableCameras();
    if (listDesciption.isNotEmpty) {
      CameraDescription cameraDescription;
      if (listDesciption
          .where((element) =>
              element.lensDirection == CameraLensDirection.external)
          .isNotEmpty) {
        cameraDescription = listDesciption
            .where((element) =>
                element.lensDirection == CameraLensDirection.external)
            .first;
      } else {
        if (listDesciption
            .where((element) =>
                element.lensDirection == CameraLensDirection.external)
            .isNotEmpty) {
          cameraDescription = listDesciption
              .where((element) =>
                  element.lensDirection == CameraLensDirection.external)
              .first;
        } else {
          cameraDescription = listDesciption.first;
        }
      }
      controller = CameraController(
          cameraDescription, ResolutionPreset.ultraHigh,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
      await controller?.initialize().whenComplete(() => isInitialize = true);
    }
  }

  start() {
    if (isInitialize) controller?.startVideoRecording();
  }

  Future<File?> stop() async {
    if (isInitialize) {
      if (controller?.value.isRecordingVideo == true) {
        XFile? file = await controller?.stopVideoRecording();
        if (file != null) {
          return File(file.path);
        }
      }
    }
    return null;
  }
}
