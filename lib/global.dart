import 'package:flutter/material.dart';
import 'package:sampling_machine_mobile_testing/utils/screen_size.dart';

/// new os version width 800 height 1317.3333333333333
/// old os version bool get isMachine49Inch => width == 1080 && height == 1864;
///

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool get isMachine49Inch => width == 800 && height < 1318 && height > 1317;
bool get isMachine21Inch => width == 720 && height == 1232;
