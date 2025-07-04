// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:food_limmit_controller/data/repository/item/items_repository.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:food_limmit_controller/data/repository/item/IF_item_repository_provider.dart';
// import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
// import 'package:food_limmit_controller/notification_service.dart';

// import 'notification_service_test.mocks.dart'; // テスト対象のファイル

// @GenerateNiceMocks([
//   MockSpec<ItemsRepository>(),
//   MockSpec<FlutterLocalNotificationsPlugin>(),
//   MockSpec<AndroidFlutterLocalNotificationsPlugin>(),
//   MockSpec<IOSFlutterLocalNotificationsPlugin>(),
//   //MockSpec<NotificationService>(),
// ])
// class MockNotificationService extends AsyncNotifier
//     with Mock
//     implements NotificationService {
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   // @override
//   // Future<void> build() async {
//   //   // モックの初期化を行う
//   //   await _initializeNotifications();
//   // }

//   MockNotificationService(this._flutterLocalNotificationsPlugin);

//   Future<void> _initializeNotifications() async {
//     // タイムゾーンの初期化
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));

//     // プラグインインスタンスの取得
//     _flutterLocalNotificationsPlugin = _flutterLocalNotificationsPlugin;

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
// }

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   // すべてのテスト実行前にタイムゾーンデータを一度だけ初期化
//   setUpAll(() {
//     tz.initializeTimeZones();
//     // テスト環境のタイムゾーンを固定する (日本時間)
//     tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
//   });

//   group('NotificationService', () {
//     late ProviderContainer container;
//     late ItemsRepository mockItemRepository;
//     late FlutterLocalNotificationsPlugin mockPlugin;
//     late NotificationService mockServiceProvider;

//     setUp(() {
//       mockItemRepository = MockItemsRepository();
//       mockPlugin = MockFlutterLocalNotificationsPlugin();
//       mockServiceProvider = MockNotificationService(mockPlugin);

//       // プラットフォーム固有の実装をモック
//       when(
//         mockPlugin
//             .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin
//             >(),
//       ).thenReturn(MockAndroidFlutterLocalNotificationsPlugin());
//       when(
//         mockPlugin
//             .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin
//             >(),
//       ).thenReturn(MockIOSFlutterLocalNotificationsPlugin());

//       //when(mockServiceProvider.build()).thenReturn(mockPlugin);

//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const InitializationSettings initializationSettings =
//           InitializationSettings(android: initializationSettingsAndroid);

//       // プロバイダーをテスト用にオーバーライド
//       container = ProviderContainer(
//         overrides: [
//           itemsRepositoryProvider.overrideWithValue(mockItemRepository),
//           // NotificationServiceProviderProvider をモックプラグインでオーバーライド
//           notificationServiceProvider.overrideWith(() => mockServiceProvider),
//         ],
//       );
//       when(
//         mockPlugin.initialize(
//           initializationSettings, // 引数の InitializationSettings は何でも受け入れる
//           onDidReceiveNotificationResponse: null,
//           onDidReceiveBackgroundNotificationResponse: null,
//         ),
//       ).thenAnswer(
//         (_) async => true,
//       ); // 非同期メソッドなので thenAnswer と async => true を使用
//     });

//     tearDown(() {
//       container.dispose();
//     });

//     // NotificationService のインスタンスを取得するヘルパー関数
//     Future<NotificationService> getService() async {
//       final service = await container.read(
//         notificationServiceProvider.notifier,
//       );
//       debugPrint(service.toString());
//       return service;
//     }

//     // --- Test _initializeNotifications via build ---
//     test('build method initializes the plugin correctly', () async {
//       await getService();

//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const InitializationSettings initializationSettings =
//           InitializationSettings(android: initializationSettingsAndroid);

//       //`initialize` が正しい引数で呼ばれたことを検証
//       verify(
//         mockPlugin.initialize(
//           initializationSettings, // InitializationSettings
//           onDidReceiveNotificationResponse: null,
//           onDidReceiveBackgroundNotificationResponse: null,
//         ),
//       ).called(1);
//     });

//     // --- Test requestPermissions ---
//     test(
//       'requestPermissions calls platform specific request methods',
//       () async {
//         final service = await getService();
//         service.requestPermissions();

//         verify(
//           mockPlugin
//               .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin
//               >()
//               ?.requestNotificationsPermission(),
//         ).called(1);
//         verify(
//           mockPlugin
//               .resolvePlatformSpecificImplementation<
//                 IOSFlutterLocalNotificationsPlugin
//               >()
//               ?.requestPermissions(alert: true, badge: true, sound: true),
//         ).called(1);
//       },
//     );

//     // --- Test notificationDateCounter ---
//     group('notificationDateCounter', () {
//       late NotificationService service;

//       setUp(() async {
//         service = await getService(); // 各テストで初期化済みサービスインスタンスを取得
//       });

//       test('should return empty string if no items are present', () {
//         final now = DateTime(2025, 5, 1);
//         final result = service.notificationDateCounter([], now);
//         expect(result, '');
//       });

//       test('should count "要注意" and "注意" correctly on the 1st of the month', () {
//         final now = DateTime(2025, 5, 1, 9, 0, 0); // 5月1日の通知
//         final items = [
//           ItemModel(
//             id: 1,
//             imagePath: '',
//             expirationDate: DateTime(2025, 4, 16),
//           ), // 期限切れ (要注意)
//           ItemModel(
//             id: 2,
//             imagePath: '',
//             expirationDate: DateTime(2025, 5, 1),
//           ), // 今日 (要注意)
//           ItemModel(
//             id: 3,
//             imagePath: '',
//             expirationDate: DateTime(2025, 5, 16),
//           ), // 今月16日 (要注意)
//           ItemModel(
//             id: 4,
//             imagePath: '',
//             expirationDate: DateTime(2025, 6, 1),
//           ), // 翌月1日 (注意)
//           ItemModel(
//             id: 5,
//             imagePath: '',
//             expirationDate: DateTime(2025, 6, 16),
//           ), // 翌月16日 (注意の範囲外)
//           ItemModel(
//             id: 6,
//             imagePath: '',
//             expirationDate: DateTime(2025, 7, 1),
//           ), // 遠い未来 (注意の範囲外)
//         ];
//         final result = service.notificationDateCounter(items, now);
//         // 要注意: 1, 2, 3 (3件)
//         // 注意: 4 (1件)
//         expect(result, "要注意が 3 件、注意が 1 件あります。");
//       });

//       test(
//         'should count "要注意" and "注意" correctly on the 16th of the month',
//         () {
//           final now = DateTime(2025, 5, 16, 9, 0, 0); // 5月16日の通知
//           final items = [
//             ItemModel(
//               id: 1,
//               imagePath: '',
//               expirationDate: DateTime(2025, 5, 1),
//             ), // 期限切れ (要注意)
//             ItemModel(
//               id: 2,
//               imagePath: '',
//               expirationDate: DateTime(2025, 5, 16),
//             ), // 今日 (要注意)
//             ItemModel(
//               id: 3,
//               imagePath: '',
//               expirationDate: DateTime(2025, 6, 1),
//             ), // 翌月1日 (要注意)
//             ItemModel(
//               id: 4,
//               imagePath: '',
//               expirationDate: DateTime(2025, 6, 16),
//             ), // 翌月16日 (注意)
//             ItemModel(
//               id: 5,
//               imagePath: '',
//               expirationDate: DateTime(2025, 7, 1),
//             ), // 遠い未来 (注意の範囲外)
//           ];
//           final result = service.notificationDateCounter(items, now);
//           // 要注意: 1, 2, 3 (3件)
//           // 注意: 4 (1件)
//           expect(result, "要注意が 3 件、注意が 1 件あります。");
//         },
//       );

//       test('should count only "要注意" if no "注意" items', () {
//         final now = DateTime(2025, 5, 1);
//         final items = [
//           ItemModel(id: 1, imagePath: '', expirationDate: DateTime(2025, 5, 1)),
//           ItemModel(
//             id: 2,
//             imagePath: '',
//             expirationDate: DateTime(2025, 5, 16),
//           ),
//           ItemModel(
//             id: 3,
//             imagePath: '',
//             expirationDate: DateTime(2025, 7, 1),
//           ), // 遠い未来
//         ];
//         final result = service.notificationDateCounter(items, now);
//         expect(result, "要注意が 2 件あります。");
//       });

//       test('should count only "注意" if no "要注意" items (on 1st)', () {
//         final now = DateTime(2025, 5, 1);
//         final items = [
//           ItemModel(
//             id: 1,
//             imagePath: '',
//             expirationDate: DateTime(2025, 6, 1),
//           ), // 翌月1日 (注意)
//           ItemModel(
//             id: 2,
//             imagePath: '',
//             expirationDate: DateTime(2025, 7, 1),
//           ), // 遠い未来
//         ];
//         final result = service.notificationDateCounter(items, now);
//         expect(result, "注意が 1 件あります。");
//       });

//       test('should count only "注意" if no "要注意" items (on 16th)', () {
//         final now = DateTime(2025, 5, 16);
//         final items = [
//           ItemModel(
//             id: 1,
//             imagePath: '',
//             expirationDate: DateTime(2025, 6, 16),
//           ), // 翌月16日 (注意)
//           ItemModel(
//             id: 2,
//             imagePath: '',
//             expirationDate: DateTime(2025, 7, 1),
//           ), // 遠い未来
//         ];
//         final result = service.notificationDateCounter(items, now);
//         expect(result, "注意が 1 件あります。");
//       });

//       test(
//         'should return empty string if only future items outside both ranges',
//         () {
//           final now = DateTime(2025, 5, 1);
//           final items = [
//             ItemModel(
//               id: 1,
//               imagePath: '',
//               expirationDate: DateTime(2025, 7, 1),
//             ),
//             ItemModel(
//               id: 2,
//               imagePath: '',
//               expirationDate: DateTime(2025, 7, 16),
//             ),
//           ];
//           final result = service.notificationDateCounter(items, now);
//           expect(result, '');
//         },
//       );
//     });

//     // --- Test scheduleDailyNotifications ---
//     group('scheduleDailyNotifications', () {
//       late NotificationService service;

//       setUp(() async {
//         service = await getService();
//         when(
//           mockItemRepository.fetchItems(),
//         ).thenAnswer((_) async => []); // デフォルトで空リストを返す
//       });

//       test('calls cancelAll and fetches items', () async {
//         await service.scheduleDailyNotifications();
//         verify(mockPlugin.cancelAll()).called(1);
//         verify(mockItemRepository.fetchItems()).called(1);
//       });

//       test(
//         'does not schedule notification if no items are found within ranges',
//         () async {
//           when(mockItemRepository.fetchItems()).thenAnswer(
//             (_) async => [
//               ItemModel(
//                 id: 1,
//                 imagePath: '',
//                 expirationDate: DateTime(2026, 1, 1),
//               ), // 遠い未来
//             ],
//           );
//           await service.scheduleDailyNotifications();
//           verifyNever(
//             mockPlugin.zonedSchedule(
//               1,
//               any,
//               any,
//               tz.TZDateTime.from(DateTime.now(), tz.local),
//               NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   'food_limit_channel',
//                   '賞味期限通知',
//                   channelDescription: '賞味期限の通知',
//                 ),
//               ),
//               androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//               matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
//               payload: anyNamed('payload'),
//             ),
//           );
//         },
//       );

//       test(
//         'schedules two notifications (1st and 16th) if items are found',
//         () async {
//           when(mockItemRepository.fetchItems()).thenAnswer(
//             (_) async => [
//               ItemModel(
//                 id: 1,
//                 imagePath: '',
//                 expirationDate: DateTime(2025, 5, 10),
//               ), // 要注意のアイテム
//             ],
//           );
//           await service.scheduleDailyNotifications();

//           // 1日の通知がスケジュールされたことを検証
//           verify(
//             mockPlugin.zonedSchedule(
//               1, // ID
//               '賞味期限のお知らせ', // title
//               argThat(
//                 contains('要注意が 1 件'),
//               ), // body (notificationDateCounterの結果)
//               tz.TZDateTime.from(DateTime.now(), tz.local), // scheduledDate
//               NotificationDetails(), // notificationDetails
//               androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//               matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
//               payload: 'daily_summary',
//             ),
//           ).called(1);

//           // 16日の通知がスケジュールされたことを検証
//           verify(
//             mockPlugin.zonedSchedule(
//               16, // ID
//               '賞味期限のお知らせ', // title
//               argThat(contains('要注意が 1 件')), // body
//               tz.TZDateTime.from(DateTime.now(), tz.local), // scheduledDate
//               NotificationDetails(), // notificationDetails
//               androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//               matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
//               payload: 'daily_summary',
//             ),
//           ).called(1);
//         },
//       );
//     });
//   });
// }
