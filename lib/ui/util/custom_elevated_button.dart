import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({super.key, this.child, this.onPressed});
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool delay = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (delay == false) {
          delay = true;
          debugPrint('delayStart $delay');
          widget.onPressed?.call();
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
