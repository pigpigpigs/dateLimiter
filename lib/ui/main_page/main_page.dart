import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_limmit_controller/domain/model/Item/item.dart';
import 'package:food_limmit_controller/ui/camera/camera_page.dart';
import 'package:food_limmit_controller/ui/main_page/view_model/complete_animation_view_model.dart';
import 'package:food_limmit_controller/ui/main_page/view_model/main_page_view_model.dart';
import 'package:food_limmit_controller/ui/util/custom_gesture_detector.dart';
import 'package:food_limmit_controller/ui/util/custom_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.tggle});

  final VoidCallback tggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 10,
        title: const Text('管理画面', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 55, 147, 204),
        leading: CustomIconButton(
          onTap: () {
            tggle();
          },
          icon: Icon(Icons.sort, color: Colors.white),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return Text(
                style: TextStyle(color: Colors.white),
                ref.read(mainPageViewModelProvider.notifier).showDate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  var itemListProvider = ref.watch(mainPageViewModelProvider);
                  return itemListProvider.when(
                    data: (listItem) => ItemListBlock(itemList: listItem),
                    error: (error, stacktrace) => Text(error.toString()),
                    loading:
                        () => Center(child: const CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () async {
                context.go('/camera');
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class ItemListBlock extends StatelessWidget {
  const ItemListBlock({super.key, required this.itemList});

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return ItemContextBlock(
          imagePath: itemList[index].imagePath,
          stringDateData: itemList[index].stringExpirationDate,
          id: itemList[index].id,
          ratio: itemList[index].dateRatio,
        );
      },
    );
  }
}

//ブロックのコード
class ItemContextBlock extends HookConsumerWidget {
  const ItemContextBlock({
    super.key,
    required this.imagePath,
    required this.stringDateData,
    required this.id,
    required this.ratio,
  });

  final String imagePath;
  final String stringDateData;
  final int id;
  final double ratio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnimation = ref.watch(completeAnimationFlugProvider);
    final AnimationController deleteAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 200));

    final boxWidthSize = MediaQuery.of(context).size.width / 3;

    //final deleteBlockId = useState(<int>[]);
    final Color dateRatioColor = ref
        .read(mainPageViewModelProvider.notifier)
        .getDateRatioColor(ratio);

    if (deleteAnimationController.isCompleted && !isAnimation) {
      // アニメーションが完了し、かつ他のアニメーションも進行中でなければ非表示に
      // これは deleteItem がリストを更新する前の短い期間に有効
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: deleteAnimationController,
      builder: (context, child) {
        var scale = 1 - deleteAnimationController.value * 0.99;
        return Transform(
          transform: Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
                  ratio == 0
                      ? BorderSide(width: 4, color: dateRatioColor)
                      : BorderSide.none,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    //ここに色
                    dateRatioColor,
                    Colors.white,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [ratio, ratio],
                ),
              ),
              width: boxWidthSize,
              child: CustomGestureDetector(
                onDoubleTap: () async {
                  if (isAnimation) return;
                  ref
                      .read(completeAnimationFlugProvider.notifier)
                      .animationFlugChanger(true);
                  await Future.wait([
                    deleteAnimationController.forward(),
                    ref.read(mainPageViewModelProvider.notifier).deleteItem(id),
                  ]);
                  deleteAnimationController.reset();
                  ref
                      .read(completeAnimationFlugProvider.notifier)
                      .animationFlugChanger(false);
                },
                child: Center(
                  child: Column(
                    children: [
                      imagePath == ''
                          ? const Text('noneImage')
                          : Expanded(
                            child: Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                              width: boxWidthSize * 1.1,
                              height: boxWidthSize * 1.1,
                            ),
                          ),
                      stringDateData == ''
                          ? const Text('noneDate')
                          : Text(stringDateData),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
