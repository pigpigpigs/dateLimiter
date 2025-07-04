import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector({
    super.key,
    this.onDoubleTap,
    this.onTap,
    this.child,
  });
  final VoidCallback? onDoubleTap;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  bool delay = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (delay == false) {
          delay = true;
          debugPrint('delayStart $delay');
          widget.onTap?.call();
          Future.delayed(const Duration(milliseconds: 1000)).then((_) {
            delay = false;
            debugPrint('delayEnd $delay');
          });
        }
      },
      onDoubleTap: () {
        if (delay == false) {
          delay = true;
          debugPrint('delayStart $delay');
          widget.onDoubleTap?.call();
          Future.delayed(const Duration(milliseconds: 1000)).then((_) {
            delay = false;
            debugPrint('delayEnd $delay');
          });
        }
      },
      child: widget.child,
    );
  }
}
