//import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_limmit_controller/ui/main_page/main_page.dart';
import 'package:food_limmit_controller/ui/setting_page/setting_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyScreen extends HookConsumerWidget {
  const MyScreen({super.key});
  final maxSlide = 280.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnimationController settingPageAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 200));

    final canBeDragged = useState(false);

    void onDragStart(DragStartDetails details) {
      debugPrint('onDrag');
      bool isDragOpenFromLeft =
          settingPageAnimationController.isDismissed &&
          details.globalPosition.dx < 80;
      bool isDragCloseFromRight =
          settingPageAnimationController.isCompleted &&
          details.globalPosition.dx > 80;

      canBeDragged.value = isDragOpenFromLeft || isDragCloseFromRight;
    }

    void onDragUpdate(DragUpdateDetails details) {
      if (canBeDragged.value) {
        double delta = details.primaryDelta! / maxSlide;
        settingPageAnimationController.value += delta;
      }
    }

    void onDragEnd(DragEndDetails details) {
      if (settingPageAnimationController.isDismissed ||
          settingPageAnimationController.isCompleted) {
        return;
      }
      debugPrint('アニメーション中');
      if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
        double visualVelocity =
            details.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.width;
        settingPageAnimationController.fling(velocity: visualVelocity);
      } else if (settingPageAnimationController.value < 0.5) {
        settingPageAnimationController.reverse();
      } else {
        settingPageAnimationController.forward();
      }
    }

    void tggle() {
      settingPageAnimationController.isDismissed
          ? settingPageAnimationController.forward()
          : settingPageAnimationController.reverse();
    }

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: AnimatedBuilder(
          animation: settingPageAnimationController,
          builder: (context, child) {
            final scale = 1 - settingPageAnimationController.value * 0.3;
            final slider = maxSlide * settingPageAnimationController.value;
            return Stack(
              children: [
                SettingPage(),
                Transform(
                  transform:
                      Matrix4.identity()
                        ..translate(slider, slider)
                        ..scale(scale),
                  child: MainPage(tggle: tggle),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
