import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({super.key, required this.onTap, required this.icon,this.iconSize});
  final VoidCallback onTap;
  final Icon icon;
  final double? iconSize;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool delay = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.iconSize,
      onPressed: () {
        if (delay == false) {
          delay = true;
          widget.onTap();
          debugPrint('delayStart $delay');
          Future.delayed(const Duration(milliseconds: 1000)).then((_) {
            delay = false;
            debugPrint('delayEnd $delay');
          });
        }
      },
      icon: widget.icon,
    );
  }
}
