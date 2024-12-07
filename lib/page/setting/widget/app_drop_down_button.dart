import 'package:flutter/material.dart';
import 'package:sampling_machine_mobile_testing/constant/app_color.dart';
import 'package:sampling_machine_mobile_testing/model/scan_snap_setting_button_model.dart';

class AppDropDownButton extends StatefulWidget {
  final int? value;
  final String hint;
  final List<ScanSnapSettingButtonModel> items;
  final Function(int? e) onChanged;
  const AppDropDownButton(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.hint});

  @override
  State<StatefulWidget> createState() => AppDropDownButtonState();
}

class AppDropDownButtonState extends State<AppDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        hint: Text(
          widget.hint,
          style: const TextStyle(color: AppColor.grayWeight),
        ),
        items: widget.items
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(
                    e.label,
                    style: const TextStyle(color: AppColor.black),
                  ),
                ))
            .toList(),
        value: widget.items.any((element) => element.value == widget.value)
            ? widget.value
            : null,
        onChanged: widget.onChanged);
  }
}
