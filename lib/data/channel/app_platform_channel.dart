import 'package:flutter/services.dart';

EventChannel scanChannel =
    const EventChannel('com.mvc.sampling_machine_mobile_testing/scan_listen');
MethodChannel writeChannel =
    const MethodChannel("com.mvc.sampling_machine_mobile_testing/send");
EventChannel readChannel =
    const EventChannel('com.mvc.sampling_machine_mobile_testing/usb_listen');
