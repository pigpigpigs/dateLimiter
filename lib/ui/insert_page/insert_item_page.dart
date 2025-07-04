import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_limmit_controller/ui/insert_page/view_model/date_view_model.dart';
import 'package:food_limmit_controller/ui/insert_page/view_model/insert_page_view_model.dart';
import 'package:food_limmit_controller/ui/util/custom_dialog.dart';
import 'package:food_limmit_controller/ui/util/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InsertPage extends HookConsumerWidget {
  const InsertPage({super.key, required this.imagePath});

  final String imagePath;

  //推されている（指定している）ボタン
  Widget setedButtonContext(String text, WidgetRef ref, String ymd) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: (Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          sortYMD(ymd, ref, text);
        },
        child: Text(text),
      ),
    );
  }

  //指定されていないボタン
  Widget buttonContext(String text, WidgetRef ref, String ymd) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          sortYMD(ymd, ref, text);
        },
        child: Text(text),
      ),
    );
  }

  void sortYMD(String ymd, WidgetRef ref, String text) {
    switch (ymd) {
      case 'year':
        ref.read(dateViewModelProvider.notifier).setYearDate(text);
        break;
      case 'month':
        ref.read(dateViewModelProvider.notifier).setMonthDate(text);
        break;
      case 'day':
        ref.read(dateViewModelProvider.notifier).setDayDate(text);
        break;
    }
  }

  Widget yearButtons(
    double oneFifrthScreenWidth,
    WidgetRef ref,
    var dateProvider,
    List<String> yearButton,
  ) {
    //指定されている年のボタンを表示
    return SizedBox(
      width: oneFifrthScreenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            yearButton.map((e) {
              if (e == dateProvider.year) {
                return setedButtonContext(e, ref, 'year');
              } else {
                return buttonContext(e, ref, 'year');
              }
            }).toList(),
      ),
    );
  }

  Widget monthButtons(
    WidgetRef ref,
    var dateProvider,
    List<List<String>> monthButtons,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var row in monthButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  row.map((e) {
                    if (e == dateProvider.month) {
                      return setedButtonContext(e, ref, 'month');
                    } else {
                      return buttonContext(e, ref, 'month');
                    }
                  }).toList(),
            ),
        ],
      ),
    );
  }

  Widget dayButtons(
    double oneFifthScreenWidth,
    WidgetRef ref,
    var dateProvider,
    List<String> dayButtons,
  ) {
    return SizedBox(
      width: oneFifthScreenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            dayButtons.map((e) {
              if (e == dateProvider.day) {
                return setedButtonContext(e, ref, 'day');
              } else {
                return buttonContext(e, ref, 'day');
              }
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insertProvider = ref.watch(insertPageViewModelProvider(imagePath));
    final dateProvider = ref.watch(dateViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final oneFifthScreenWidth = screenWidth / 5;
    final nowYear = DateTime.now().year.toString().substring(2);
    final oneYearLater = (DateTime.now().year + 1).toString().substring(2);
    final towYearLater = (DateTime.now().year + 2).toString().substring(2);

    final List<String> yearButtonNum = [nowYear, oneYearLater, towYearLater];

    final dayButtonNum = ['上旬', '下旬'];

    final List<List<String>> monthButtonNum = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['10', '11', '12'],
    ];

    late String cutImagePath;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            insertProvider.when(
              data: (data) {
                cutImagePath = data.imagePath;
                return Expanded(
                  child: SizedBox(
                    //height: 350,
                    //width: 400,
                    child: Image.file(File(cutImagePath), fit: BoxFit.contain),
                  ),
                );
              },
              error: (error, stackTrace) {
                return const Text('error');
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Expanded(
              child: SizedBox.expand(
                child: Row(
                  children: [
                    yearButtons(
                      oneFifthScreenWidth,
                      ref,
                      dateProvider,
                      yearButtonNum,
                    ),
                    monthButtons(ref, dateProvider, monthButtonNum),
                    dayButtons(
                      oneFifthScreenWidth,
                      ref,
                      dateProvider,
                      dayButtonNum,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 80,
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final result = await showConfirmDialog(
                        context,
                        title: const Text('移動'),
                        content: const Text('撮影した写真を破棄して戻ってもよろしいですか？'),
                      );
                      //非同期処理中にcontextが破棄されていないかの確認
                      if (!context.mounted) return;
                      if (result == true) {
                        context.go('/');
                      }
                    },
                    child: const Text('やめる'),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: CustomElevatedButton(
                    onPressed: () async {
                      //画像を保存してから画面遷移
                      await ref
                          .read(insertPageViewModelProvider(imagePath).notifier)
                          .saveImage(cutImagePath);
                      context.go('/camera');

                      // if (context.mounted) Navigator.of(context).pop();
                    },
                    child: const Text('決定'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
