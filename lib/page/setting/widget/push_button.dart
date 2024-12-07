import 'package:flutter/material.dart';
import 'package:sampling_machine_mobile_testing/constant/font_size.dart';

class PushButton extends StatefulWidget {
  final Function(int index) onTap;
  final int index;
  const PushButton({super.key, required this.index, required this.onTap});

  @override
  State<StatefulWidget> createState() => PushButtonState();
}

class PushButtonState extends State<PushButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        widget.onTap(widget.index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(4)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.index.toString(),
            style: TextStyle(color: Colors.white, fontSize: FontSize.medium),
          ),
        ),
      ),
    );
  }
}
