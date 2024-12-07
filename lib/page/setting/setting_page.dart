import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampling_machine_mobile_testing/constant/app_color.dart';
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
              body: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.grayWeight,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                      _machineSetting(context),
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
                style: TextStyle(fontSize: FontSize.medium),
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
                style: TextStyle(fontSize: FontSize.medium),
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
                    await context.read<SettingProvider>().resetRootPosition();
                  },
                  child: const Text("Reset vị trí gốc của các ngăn"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().initConfigStacks();
                  },
                  child: const Text("Cấu hình ngăn hàng lần đầu"))),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await context.read<SettingProvider>().separateAllStacks();
                  },
                  child: const Text("Tách Toàn bộ các ngăn đang gộp"))),
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
}
