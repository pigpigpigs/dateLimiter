import 'package:flutter/material.dart';
import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
import 'package:food_limmit_controller/ui/setting_page/setting_page_view_model.dart';
import 'package:food_limmit_controller/ui/util/custom_dialog.dart';
import 'package:food_limmit_controller/ui/util/custom_radio_button.dart';
import 'package:food_limmit_controller/ui/util/custom_textbutton_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingProvider = ref.watch(settingPageViewModelProvider);
    final settingNotifier = ref.read(settingPageViewModelProvider.notifier);

    const List<String> sortList = ['id', 'expirationDate'];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 68, 84, 255)),
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '設定画面',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  //下記のCustomTextButtonIconに縦のラインを合わせるために使用
                  CustomTextbuttonIcon(
                    icon: Icon(Icons.sort, color: Colors.white),
                    label: const Text(
                      '並び替え',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        CustomRadioButton(
                          selectedColor: Colors.white,
                          unselectedColor: Colors.white,
                          value: sortList[0],
                          groupValue:
                              settingProvider
                                  .whenData((value) => value.sortData)
                                  .value,
                          onChanged: (val) {
                            settingNotifier.changeSort(val.toString());
                          },
                        ),
                        SizedBox(width: 10),
                        Text('登録順', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        CustomRadioButton(
                          selectedColor: Colors.white,
                          unselectedColor: Colors.white,
                          value: sortList[1],
                          groupValue:
                              settingProvider
                                  .whenData((value) => value.sortData)
                                  .value,
                          onChanged: (val) {
                            settingNotifier.changeSort(val.toString());
                          },
                        ),
                        SizedBox(width: 10),
                        Text('賞味期限が近い順', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextbuttonIcon(
                    onPressed: () async {
                      final result = await showConfirmDialog(
                        context,
                        title: const Text('商品の削除'),
                        content: const Text('期限切れ商品のみ削除しますか？'),
                      );
                      if (result == true) {
                        ref
                            .read(settingPageViewModelProvider.notifier)
                            .pushDeleteLimitoutItemButton();
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      '期限切れ商品のみ削除',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextbuttonIcon(
                    onPressed: () async {
                      final result = await showConfirmDialog(
                        context,
                        title: const Text('商品の削除'),
                        content: const Text('期限切れ商品のみ削除しますか？'),
                      );
                      if (result == true) {
                        ref
                            .read(settingPageViewModelProvider.notifier)
                            .pushAllDeleteButtom();
                      }
                    },
                    icon: Icon(Icons.delete_forever, color: Colors.white),
                    label: Text(
                      '全てのデータを削除',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 60),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // データの取得中はローディング表示
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Version Error',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Text(
                          'Ver ${snapshot.data!.version}', // バージョン情報表示
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      }
                      //デフォルトはナにもなし
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
