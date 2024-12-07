import 'package:flutter/material.dart';
import 'package:sampling_machine_mobile_testing/constant/app_config.dart';
import 'package:sampling_machine_mobile_testing/global.dart';
import 'package:sampling_machine_mobile_testing/page/setting/setting_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

Future<void> setUp() async {
  await AppConfig.initialize();
  await ServiceLocator.initialize();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp().then((value) => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: "MVC SM Testing",
        home: const SettingPage(),
        supportedLocales: const [Locale('en', ''), Locale('vi')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      )));
}
