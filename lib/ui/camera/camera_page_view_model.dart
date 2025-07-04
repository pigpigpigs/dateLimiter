import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;

part 'camera_page_view_model.g.dart';

@riverpod
class CameraPageViewModel extends _$CameraPageViewModel {
  CameraController? cameraController;
  @override
  Future<CameraController> build() async {
    final cameraController = await initCamera();
    ref.onDispose(() {
      cameraController.dispose();
      debugPrint("カメラステートを削除しました");
    });
    return cameraController;
  }

  Future<CameraController> initCamera() async {
    debugPrint('initVameraが動いた');
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    CameraController cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    await cameraController.initialize();
    return cameraController;
  }

  Future<void> disposeCamera() async {
    final camera = state.value;
    return await camera!.dispose();
  }

  Future<String> cutImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      final img.Image? originalImage = img.decodeImage(
        await imageFile.readAsBytes(),
      );

      if (originalImage == null) {
        debugPrint('画像のデコードに失敗しました: $imagePath');
        return imagePath; // 失敗した場合は元のパスを返す
      }

      final int originalWidth = originalImage.width;
      final int originalHeight = originalImage.height;

      if (originalWidth == originalHeight) {
        // すでに1:1なのでそのまま返す
        return imagePath;
      }

      int cropSize;
      int cropOffsetX = 0;
      int cropOffsetY = 0;

      if (originalHeight > originalWidth) {
        cropSize = originalWidth;
        cropOffsetY = (originalHeight - cropSize) ~/ 2;
      } else {
        // 横長の写真（念のため）
        cropSize = originalHeight;
        cropOffsetX = (originalWidth - cropSize) ~/ 2;
      }

      final img.Image croppedImage = img.copyCrop(
        originalImage,
        x: cropOffsetX,
        y: cropOffsetY,
        width: cropSize,
        height: cropSize,
      );

      final Directory tempDir = await getTemporaryDirectory();
      final String croppedImagePath = path.join(
        tempDir.path,
        'cropped_${path.basename(imagePath)}',
      );
      final File croppedFile = File(croppedImagePath);

      // JPEGとして保存
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));

      return croppedImagePath;
    } catch (e) {
      debugPrint('画像のカット処理中にエラーが発生しました: $e');
      return imagePath; // エラーが発生した場合は元のパスを返す
    }
  }
}
