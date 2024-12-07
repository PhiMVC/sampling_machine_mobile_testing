import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampling_machine_mobile_testing/constant/app_color.dart';
import 'package:sampling_machine_mobile_testing/constant/font_size.dart';
import 'package:sampling_machine_mobile_testing/data/shared_prefs/shared_prefs.dart';
import 'package:sampling_machine_mobile_testing/model/stack_model_hive.dart';
import 'package:sampling_machine_mobile_testing/page/setting/setting_provider.dart';
import 'package:sampling_machine_mobile_testing/utils/service_locator.dart';

class StackButton extends StatefulWidget {
  final StackModelHive stack;
  const StackButton({super.key, required this.stack});

  @override
  State<StatefulWidget> createState() => StackButtonState();
}

class StackButtonState extends State<StackButton> {
  Color disable = AppColor.grayWeight;
  Color enable = AppColor.primary;
  void changeState() => setState(() {
        widget.stack.merge = !widget.stack.merge;
        locator<SharedPrefs>()
            .changeStackModel(widget.stack.address, widget.stack);
      });
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant StackButton oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        changeState();
        widget.stack.merge
            ? context.read<SettingProvider>().combineStack(widget.stack.address)
            : context
                .read<SettingProvider>()
                .separateOneStack(widget.stack.address);
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.stack.merge ? enable : disable,
            borderRadius: BorderRadius.circular(4)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.stack.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: FontSize.medium),
          ),
        ),
      ),
    );
  }
}
