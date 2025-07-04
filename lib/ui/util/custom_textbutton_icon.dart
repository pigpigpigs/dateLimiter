import 'package:flutter/material.dart';

class CustomTextbuttonIcon extends StatefulWidget {
  const CustomTextbuttonIcon({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });
  final Icon icon;
  final Widget label;
  final VoidCallback? onPressed;

  @override
  State<CustomTextbuttonIcon> createState() => _CustomTextbuttonIconState();
}

class _CustomTextbuttonIconState extends State<CustomTextbuttonIcon> {
  bool delay = false;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        if (delay == false) {
          widget.onPressed?.call();
          delay = true;
          debugPrint('delayStart $delay');
          Future.delayed(const Duration(milliseconds: 1000)).then((_) {
            debugPrint('delayEnd $delay');
            delay = false;
          });
        }
      },
      label: widget.label,
      icon: widget.icon,
    );
  }
}
