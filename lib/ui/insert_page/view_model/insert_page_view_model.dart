import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
import 'package:food_limmit_controller/domain/model/insert_item/insert_item.dart';
import 'package:food_limmit_controller/ui/insert_page/view_model/date_view_model.dart';
import 'package:food_limmit_controller/ui/main_page/view_model/main_page_view_model.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insert_page_view_model.g.dart';

@riverpod
class InsertPageViewModel extends _$InsertPageViewModel {
  @override
  Future<InsertItem> build(String imagePath) async {
    return InsertItem(
      imagePath: await cutImage(imagePath),
      expirationDate: DateTime.now(),
    );
  }

  Future<String> cutImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    try {
      final File imageFile = File(imagePath);
      final img.Image? originalImage = img.decodeImage(
        await imageFile.readAsBytes(),
      );

      if (originalImage == null) {
        debugPrint('画像のデコードに失敗しました: $imagePath');
        return '';
      }

      // トリミング処理
      final int originalWidth = originalImage.width;
      final int originalHeight = originalImage.height;
      if (originalWidth == originalHeight) {
        return imagePath;
      }
      int cropSize;
      int cropOffsetX = 0;
      int cropOffsetY = 0;
      if (originalHeight > originalWidth) {
        cropSize = originalWidth;
        cropOffsetY = (originalHeight - cropSize) ~/ 2;
      } else {
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

      final Directory? documentsDir = await getExternalStorageDirectory();
      Directory? appDocumentsDir;
      if (Platform.isIOS) {
        appDocumentsDir = await getApplicationDocumentsDirectory();
      } else if (documentsDir != null) {
        appDocumentsDir = documentsDir;
      } else {
        appDocumentsDir = await getApplicationDocumentsDirectory();
      }

      if (appDocumentsDir == null) {
        debugPrint('ドキュメントディレクトリの取得に失敗しました。');
        return '';
      }

      final String croppedFileName = 'cropped_${path.basename(imagePath)}';
      final String croppedImagePath = path.join(
        appDocumentsDir.path,
        croppedFileName,
      );
      final File croppedFile = File(croppedImagePath);
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
      return croppedImagePath;
    } catch (e) {
      debugPrint('画像のカット処理中にエラーが発生しました: $e');
      return '';
    }
  }

  // 賞味期限入力後,DBに画像を保存するメソッド
  Future<void> saveImage(String? originalImagePath) async {
    if (originalImagePath == null || originalImagePath.isEmpty) {
      return;
    }
    try {
      final File originalFile = File(originalImagePath);
      //ドキュメントディレクトリパスの宣言
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();

      final String finalFileName =
          'item_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String finalImagePath = path.join(
        appDocumentsDir.path,
        finalFileName,
      );
      await originalFile.copy(finalImagePath);
      final DateTime expirationDate =
          ref.read(dateViewModelProvider.notifier).fromStringToDate();
      final requestItemData = InsertItem(
        imagePath: finalImagePath,
        expirationDate: expirationDate,
      );
      await ref.read(itemsRepositoryProvider).addItem(requestItemData);
      ref.invalidate(mainPageViewModelProvider);
    } catch (e) {
      debugPrint('最終画像の保存処理中にエラーが発生しました: $e');
      return;
    }
  }
}
