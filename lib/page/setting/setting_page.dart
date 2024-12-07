import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampling_machine_mobile_testing/constant/font_size.dart';
import 'package:sampling_machine_mobile_testing/model/scan_snap_setting_button_model.dart';
import 'package:sampling_machine_mobile_testing/page/setting/setting_provider.dart';
import 'package:sampling_machine_mobile_testing/page/setting/widget/app_drop_down_button.dart';
import 'package:sampling_machine_mobile_testing/page/setting/widget/push_button.dart';
import 'package:sampling_machine_mobile_testing/page/setting/widget/stack_button.dart';
import 'package:sampling_machine_mobile_testing/utils/scan_snap_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingProvider>(
      create: (BuildContext context) {
        return SettingProvider();
      },
      child: Consumer<SettingProvider>(builder: (context, provider, _) {
        return Theme(
            data: ThemeData(
                appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
                elevatedButtonTheme: const ElevatedButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.grey)))),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("MVC SM Testing"),
                centerTitle: true,
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                  child: Column(children: [
                _machineSetting(context),
                // _scanSnapSetting(context),
              ])),
            ));
      }),
    );
  }

  Widget _buildGridStackPush(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.read<SettingProvider>().stackPush.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return PushButton(
            index: context.read<SettingProvider>().stackPush[index],
            onTap: (index) {
              context
                  .read<SettingProvider>()
                  .requestGiveGiftTurnOnSensor(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildGridStackMergeSplit(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.read<SettingProvider>().stacks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return StackButton(
              stack: context.read<SettingProvider>().stacks[index]);
        },
      ),
    );
  }

  Widget _machineSetting(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            children: const [
              SizedBox(
                width: 25,
              ),
              Icon(Icons.admin_panel_settings),
              Text(
                "Cài đặt máy bán hàng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Text(
                "Đẩy lò xo",
                style: TextStyle(fontSize: FontSize.small),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          _buildGridStackPush(context),
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Text(
                "Gộp/Tách ngăn hàng",
                style: TextStyle(fontSize: FontSize.small),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          _buildGridStackMergeSplit(context),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().requestCheckSensor();
                  },
                  child: const Text("Yêu cầu check cảm biến rơi"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context
                        .read<SettingProvider>()
                        .requestNoCheckSensor();
                  },
                  child: const Text("Yêu cầu không check cảm biến rơi"))),
          const SizedBox(
            height: 6,
          ),
          // SizedBox(
          //     width: MediaQuery.of(context).size.width - 50,
          //     child: ElevatedButton(
          //         onPressed: () async {
          //           await context.read<SettingProvider>().deleteEngineFailure();
          //         },
          //         child: const Text("Reset vị trí gốc của các ngăn"))),
          // const SizedBox(
          //   height: 6,
          // ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().configStacks();
                  },
                  child: const Text("Cấu hình ngăn hàng"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().turnOnLed();
                  },
                  child: const Text("Bật LED"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().turnOffLed();
                  },
                  child: const Text("Tắt LED"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().readState();
                  },
                  child: const Text("Đọc trạng thái cửa (Đóng/mở)"))),
          const SizedBox(
            height: 12,
          ),
        ],
      );

  Widget _scanSnapSetting(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            children: const [
              SizedBox(
                width: 25,
              ),
              Icon(Icons.adf_scanner),
              Text(
                "Cài đặt máy ScanSnap",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn cỡ giấy",
                  value: context.read<SettingProvider>().sharedPrefs.paperSize,
                  items: [
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_AUTO",
                      PAPER_SIZE_OPTION_AUTO,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_LETTER",
                      PAPER_SIZE_OPTION_LETTER,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_LEGAL",
                      PAPER_SIZE_OPTION_LEGAL,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_A4",
                      PAPER_SIZE_OPTION_A4,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_A5",
                      PAPER_SIZE_OPTION_A5,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_A6",
                      PAPER_SIZE_OPTION_A6,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_B5",
                      PAPER_SIZE_OPTION_B5,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_B6",
                      PAPER_SIZE_OPTION_B6,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_CARD",
                      PAPER_SIZE_OPTION_CARD,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_SIZE_OPTION_BUSINESSCARD",
                      PAPER_SIZE_OPTION_CARD,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setPaperSize(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn format",
                  value: context.read<SettingProvider>().sharedPrefs.formatFile,
                  items: [
                    ScanSnapSettingButtonModel(
                      "FILE_FORMAT_OPTION_JPEG",
                      FILE_FORMAT_OPTION_JPEG,
                    ),
                    ScanSnapSettingButtonModel(
                      "FILE_FORMAT_OPTION_PDF",
                      FILE_FORMAT_OPTION_PDF,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setFormatFile(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn chế độ màu scan",
                  value: context.read<SettingProvider>().sharedPrefs.colorMode,
                  items: [
                    ScanSnapSettingButtonModel(
                      "COLOR_MODE_OPTION_AUTO",
                      COLOR_MODE_OPTION_AUTO,
                    ),
                    ScanSnapSettingButtonModel(
                      "COLOR_MODE_OPTION_COLOR",
                      COLOR_MODE_OPTION_COLOR,
                    ),
                    ScanSnapSettingButtonModel(
                      "COLOR_MODE_OPTION_GRAY",
                      COLOR_MODE_OPTION_GRAY,
                    ),
                    ScanSnapSettingButtonModel(
                      "COLOR_MODE_OPTION_BW",
                      COLOR_MODE_OPTION_BW,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setColorMode(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn mức nén",
                  value:
                      context.read<SettingProvider>().sharedPrefs.compression,
                  items: [
                    ScanSnapSettingButtonModel(
                      "COMPRESSION_OPTION_LEVEL1",
                      COMPRESSION_OPTION_LEVEL1,
                    ),
                    ScanSnapSettingButtonModel(
                      "COMPRESSION_OPTION_LEVEL2",
                      COMPRESSION_OPTION_LEVEL2,
                    ),
                    ScanSnapSettingButtonModel(
                      "COMPRESSION_OPTION_LEVEL3",
                      COMPRESSION_OPTION_LEVEL3,
                    ),
                    ScanSnapSettingButtonModel(
                      "COMPRESSION_OPTION_LEVEL4",
                      COMPRESSION_OPTION_LEVEL4,
                    ),
                    ScanSnapSettingButtonModel(
                      "COMPRESSION_OPTION_LEVEL5",
                      COMPRESSION_OPTION_LEVEL5,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setCompression(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn chất lượng hình ảnh",
                  value:
                      context.read<SettingProvider>().sharedPrefs.imageQuality,
                  items: [
                    ScanSnapSettingButtonModel(
                      "IMAGE_QUALITY_OPTION_AUTO",
                      IMAGE_QUALITY_OPTION_AUTO,
                    ),
                    ScanSnapSettingButtonModel(
                      "IMAGE_QUALITY_OPTION_NORMAL",
                      IMAGE_QUALITY_OPTION_NORMAL,
                    ),
                    ScanSnapSettingButtonModel(
                      "IMAGE_QUALITY_OPTION_FINE",
                      IMAGE_QUALITY_OPTION_FINE,
                    ),
                    ScanSnapSettingButtonModel(
                      "IMAGE_QUALITY_OPTION_SUPERFINE",
                      IMAGE_QUALITY_OPTION_SUPERFINE,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setImageQuality(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn mặt scan",
                  value: context.read<SettingProvider>().sharedPrefs.scanSide,
                  items: [
                    ScanSnapSettingButtonModel(
                      "SCANNING_SIDE_OPTION_ONESURFACE",
                      SCANNING_SIDE_OPTION_ONESURFACE,
                    ),
                    ScanSnapSettingButtonModel(
                      "SCANNING_SIDE_OPTION_BOTHSURFACES",
                      SCANNING_SIDE_OPTION_BOTHSURFACES,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setScanSide(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn xoá vùng trống",
                  value:
                      context.read<SettingProvider>().sharedPrefs.blankRemove,
                  items: [
                    ScanSnapSettingButtonModel(
                      "BLANK_REMOVE_OPTION_OFF",
                      BLANK_REMOVE_OPTION_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "BLANK_REMOVE_OPTION_ON",
                      BLANK_REMOVE_OPTION_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setBlankRemove(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Chọn độ sáng",
                  value: context.read<SettingProvider>().sharedPrefs.brightness,
                  items: [
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL1",
                      BRIGHTNESS_OPTION_LEVEL1,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL2",
                      BRIGHTNESS_OPTION_LEVEL2,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL3",
                      BRIGHTNESS_OPTION_LEVEL3,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL4",
                      BRIGHTNESS_OPTION_LEVEL4,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL5",
                      BRIGHTNESS_OPTION_LEVEL5,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL6",
                      BRIGHTNESS_OPTION_LEVEL6,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL7",
                      BRIGHTNESS_OPTION_LEVEL7,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL8",
                      BRIGHTNESS_OPTION_LEVEL8,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL9",
                      BRIGHTNESS_OPTION_LEVEL9,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL10",
                      BRIGHTNESS_OPTION_LEVEL10,
                    ),
                    ScanSnapSettingButtonModel(
                      "BRIGHTNESS_OPTION_LEVEL11",
                      BRIGHTNESS_OPTION_LEVEL11,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setBrightness(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn đút nhiều hoá đơn",
                  value: context.read<SettingProvider>().sharedPrefs.multiFeed,
                  items: [
                    ScanSnapSettingButtonModel(
                      "MULTI_FEED_OPTION_OFF",
                      MULTI_FEED_OPTION_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "MULTI_FEED_OPTION_ON",
                      MULTI_FEED_OPTION_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setMultiFeed(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn bleed through",
                  value:
                      context.read<SettingProvider>().sharedPrefs.bleedThrough,
                  items: [
                    ScanSnapSettingButtonModel(
                      "BLEED_THROUGH_OPTION_OFF",
                      BLEED_THROUGH_OPTION_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "BLEED_THROUGH_OPTION_ON",
                      BLEED_THROUGH_OPTION_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setBleedThrough(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn E-Doc",
                  value: context.read<SettingProvider>().sharedPrefs.eDocMode,
                  items: [
                    ScanSnapSettingButtonModel(
                      "E_DOC_MODE_OPTION_OFF",
                      E_DOC_MODE_OPTION_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "E_DOC_MODE_OPTION_ON",
                      E_DOC_MODE_OPTION_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setEDocMode(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn chế độ đưa",
                  value: context.read<SettingProvider>().sharedPrefs.feedMode,
                  items: [
                    ScanSnapSettingButtonModel(
                      "FEED_MODE_CONTINUE_OFF",
                      FEED_MODE_CONTINUE_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "FEED_MODE_CONTINUE_ON",
                      FEED_MODE_CONTINUE_ON,
                    ),
                    ScanSnapSettingButtonModel(
                      "FEED_MODE_MANUAL_FEED_ON",
                      FEED_MODE_MANUAL_FEED_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setFeedMode(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: AppDropDownButton(
                  hint: "Tuỳ chọn bảo vệ giấy",
                  value: context
                      .read<SettingProvider>()
                      .sharedPrefs
                      .paperProtection,
                  items: [
                    ScanSnapSettingButtonModel(
                      "PAPER_PROTECTION_OPTION_OFF",
                      PAPER_PROTECTION_OPTION_OFF,
                    ),
                    ScanSnapSettingButtonModel(
                      "PAPER_PROTECTION_OPTION_ON",
                      PAPER_PROTECTION_OPTION_ON,
                    ),
                  ],
                  onChanged: (value) async {
                    await context
                        .read<SettingProvider>()
                        .setPaperProtection(value!)
                        .whenComplete(
                            () => context.read<SettingProvider>().rebuild());
                  })),
          const SizedBox(
            height: 12,
          ),
        ],
      );
}
