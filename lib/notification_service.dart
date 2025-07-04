// import 'package:flutter/material.dart';
// import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
// import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// part 'notification_service.g.dart';

// @Riverpod(keepAlive: true)
// class NotificationServicePlugin extends _$NotificationServicePlugin {
//   @override
//   FlutterLocalNotificationsPlugin build() {
//     return FlutterLocalNotificationsPlugin();
//   }
// }

// @Riverpod(keepAlive: true)
// class NotificationService extends _$NotificationService {
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   @override
//   Future<void> build() async {
//     await _initializeNotifications();
//   }

//   Future<void> _initializeNotifications() async {
//     // タイムゾーンの初期化
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));

//     // プラグインインスタンスの取得
//     _flutterLocalNotificationsPlugin = ref.read(
//       notificationServicePluginProvider,
//     );

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//         );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsDarwin,
//           macOS: initializationSettingsDarwin,
//         );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (
//         NotificationResponse notificationResponse,
//       ) async {
//         // 通知をタップしたときの処理
//         if (notificationResponse.payload != null) {
//           debugPrint('notification payload: ${notificationResponse.payload}');
//           // TODO: ここで通知からの遷移処理を実装
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: (
//         NotificationResponse notificationResponse,
//       ) async {
//         // アプリがバックグラウンドまたは終了時に通知をタップしたときの処理
//         if (notificationResponse.payload != null) {
//           debugPrint(
//             'background notification payload: ${notificationResponse.payload}',
//           );
//           // TODO: ここで通知からの遷移処理を実装
//         }
//       },
//     );
//   }

//   /// 通知の権限をリクエストする
//   Future<void> requestPermissions() async {
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.requestNotificationsPermission();
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin
//         >()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//   }

//   Future<void> scheduleDailyNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//     DateTime now = DateTime.now();
//     String notificationTitle = "賞味期限のお知らせ";
//     String notificationBody = "";
//     final responseItemModel =
//         await ref.read(itemsRepositoryProvider).fetchItems();
//     notificationBody = notificationDateCounter(responseItemModel, now);

//     if (notificationBody == '') {
//       debugPrint("通知しない");
//       return;
//     }

//     await _scheduleMonthlyNotification(
//       1,
//       9,
//       now,
//       notificationTitle,
//       notificationBody,
//     );
//     await _scheduleMonthlyNotification(
//       16,
//       9,
//       now,
//       notificationTitle,
//       notificationBody,
//     );
//   }

//   /// 月ごとの通知をスケジュールするヘルパー関数
//   Future<void> _scheduleMonthlyNotification(
//     int dayOfMonth,
//     int hour,
//     DateTime now,
//     String title,
//     String body,
//   ) async {
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       dayOfMonth,
//       hour,
//       now.minute,
//     );

//     debugPrint('通知をスケジュール: $scheduledDate - $title: $body');

//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       dayOfMonth, // ユニークな通知ID (1日と16日で区別)
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'food_limit_channel', // チャンネルID
//           '賞味期限通知', // チャンネル名
//           channelDescription: '賞味期限に関する通知',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents:
//           DateTimeComponents.dayOfMonthAndTime, // 毎月指定日時に繰り返す
//       payload: 'daily_summary',
//     );
//   }

//   String notificationDateCounter(List<ItemModel> listItemModel, DateTime now) {
//     int beCarefulCount = 0; // 賞味期限切れ
//     int bewareCount = 0; // 賞味期限間近 (次の通知日で期限切れになるもの)
//     final tz.TZDateTime currentNotificationDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       0,
//       0,
//       0,
//     ); // 今日の日付の0時0分0秒

//     tz.TZDateTime beCarefulThreshold; // 要注意の終了日
//     tz.TZDateTime bewareThreshold; // 注意の終了日

//     if (now.day == 1) {
//       // 1日の通知の場合
//       // 要注意: 賞味期限が「過ぎているもの」から「その月の下旬（16日）まで」
//       beCarefulThreshold = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month,
//         16,
//         6,
//         0,
//         0,
//       ); // その月の16日の終わりまで

//       // 注意: 上記の期間に満たないものの中で、「次の月の上旬（翌月1日）まで」
//       bewareThreshold = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month + 1,
//         1,
//         6,
//         0,
//         0,
//       ); // 翌月の1日の終わりまで
//     } else {
//       // 16日の通知の場合 (now.day == 16)
//       // 要注意: 賞味期限が「過ぎているもの」から「次の月の上旬（翌月1日）まで」
//       beCarefulThreshold = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month + 1,
//         1,
//         6,
//         00,
//         00,
//       ); // 翌月の1日の終わりまで

//       // 注意: 上記の期間に満たないものの中で、「次の月の下旬（翌月16日）まで」
//       bewareThreshold = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month + 1,
//         16,
//         6,
//         0,
//         0,
//       ); // 翌月の16日の終わりまで
//     }

//     for (var item in listItemModel) {
//       final expirationDate = tz.TZDateTime(
//         tz.local,
//         item.expirationDate.year,
//         item.expirationDate.month,
//         item.expirationDate.day,
//         0,
//         0,
//         0,
//       );
//       //要注意の判定
//       if (expirationDate.isBefore(currentNotificationDate) ||
//           expirationDate.isAtSameMomentAs(currentNotificationDate) ||
//           expirationDate.isBefore(beCarefulThreshold) ||
//           expirationDate.isAtSameMomentAs(beCarefulThreshold)) {
//         beCarefulCount++;
//       }
//       //注意の判定
//       else if (expirationDate.isAfter(beCarefulThreshold) &&
//           (expirationDate.isBefore(bewareThreshold) ||
//               expirationDate.isAtSameMomentAs(bewareThreshold))) {
//         bewareCount++;
//       }
//     }

//     if (beCarefulCount > 0 && bewareCount > 0) {
//       return "要注意が $beCarefulCount 件、注意が $bewareCount 件あります。";
//     } else if (beCarefulCount > 0) {
//       return "要注意が $beCarefulCount 件あります。";
//     } else if (bewareCount > 0) {
//       return "注意が $bewareCount 件あります。";
//     } else {
//       // 要件4: 期限切れも間近もなければ通知しない
//       debugPrint("期限切れ・間近のアイテムがないため、通知をスケジュールしません。");
//       return '';
//     }
//   }
// }
