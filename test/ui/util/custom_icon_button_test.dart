import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_limmit_controller/ui/util/custom_icon_button.dart'; // Adjust this import path to your file

void main() {
  group('CustomIconButton', () {
    testWidgets('onTap is called only once on rapid multiple taps', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      await tester.runAsync(() async {
        // ビジェットをレンダー
        await tester.pumpWidget(
          MaterialApp(
            home: CustomIconButton(
              onTap: () {
                tapCount++;
              },
              icon: const Icon(Icons.add),
            ),
          ),
        );

        // アイコンボタンを見つける
        final Finder buttonFinder = find.byType(CustomIconButton);

        // ボタンを複数回素早くタップ
        await tester.tap(buttonFinder);
        await tester.tap(buttonFinder);
        await tester.tap(buttonFinder);
        await tester.pump(); // フレームを進めるが、遅延が解決されるまで待たない

        // tapCountが1であることを確認（最初のタップのみが登録されるはず）
        expect(tapCount, 1, reason: 'ボタンは素早く複数回タップされても1回だけonTapを呼び出すべきです。');

        // 遅延期間（200ms）が終了するまで待つ
        //await tester.pumpAndSettle(const Duration(milliseconds: 2000));
        await Future.delayed(const Duration(milliseconds: 1000));
        debugPrint(tapCount.toString());

        // 遅延期間後に再度タップ
        await tester.pump();
        await tester.tap(buttonFinder);
        await tester.tap(buttonFinder);
        await tester.pump(); // フレームを進める

        // tapCountが2であることを確認（遅延後に再度タップが登録されるはず）
        expect(tapCount, 2, reason: '遅延期間終了後、ボタンは再度onTapを呼び出すべきです。');
      });
    });

    testWidgets('onTap is called multiple times when taps are spaced out', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      // ビジェットをレンダー
      await tester.pumpWidget(
        MaterialApp(
          home: CustomIconButton(
            onTap: () {
              tapCount++;
            },
            icon: const Icon(Icons.remove),
          ),
        ),
      );

      final Finder buttonFinder = find.byType(IconButton);

      // 最初のタップ
      await tester.tap(buttonFinder);
      await tester.pump();
      expect(tapCount, 1);

      // 遅延期間が終了するまで待つ
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      // 2回目のタップ
      await tester.tap(buttonFinder);
      await tester.pump();
      expect(tapCount, 2);

      // 遅延期間が終了するまで待つ
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      // 3回目のタップ
      await tester.tap(buttonFinder);
      await tester.pump();
      expect(tapCount, 3);
    });

    testWidgets('Icon is displayed correctly', (WidgetTester tester) async {
      // ビジェットをレンダー
      await tester.pumpWidget(
        MaterialApp(
          home: CustomIconButton(
            onTap: () {
              debugPrint('');
            }, // テストのためにonTapはnullでも良い
            icon: Icon(Icons.star),
          ),
        ),
      );

      // 正しいアイコンが表示されていることを確認
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
