import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_limmit_controller/ui/camera/camera_page_view_model.dart';
import 'package:food_limmit_controller/ui/insert_page/insert_item_page.dart';
import 'package:food_limmit_controller/ui/util/custom_elevated_button.dart';
import 'package:food_limmit_controller/ui/util/custom_icon_button.dart';
import 'package:go_router/go_router.dart';

class CameraPage extends ConsumerWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraController = ref.watch(cameraPageViewModelProvider);
    final heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: cameraController.when(
                data: (controller) {
                  // ここで controller.value.isInitialized をチェックする
                  if (!controller.value.isInitialized) {
                    return const Center(
                      child: CircularProgressIndicator(value: null),
                    );
                  }
                  return CameraPreview(controller);
                },
                error: (error, _) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: heightSize / 4,
                decoration: BoxDecoration(color: Colors.white),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomIconButton(
                    onTap: () {
                      context.go('/');
                    },
                    icon: Icon(Icons.keyboard_return),
                    iconSize: 50,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                height: heightSize / 4,
                child: CustomIconButton(
                  iconSize: 80,
                  icon: const Icon(Icons.camera),
                  onTap: () {
                    cameraController.when(
                      data: (controller) async {
                        final imagePath = await controller.takePicture();
                        if (!context.mounted) return;
                        context.go('/camera/insert', extra: imagePath.path);
                      },
                      error:
                          (error, _) => Center(child: Text(error.toString())),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
