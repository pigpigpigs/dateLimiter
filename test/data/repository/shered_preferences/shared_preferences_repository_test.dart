import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:food_limmit_controller/domain/model/setting/setting.dart';
import 'package:food_limmit_controller/data/repository/shared_preferences/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart'; // テスト対象のクラス
import 'shared_preferences_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MockSharedPreferencesAsync>()])
// Mockクラスの定義
// SharedPreferencesAsyncは実際にはshared_preferencesパッケージのSharedPreferencesWrapperをラップしていると仮定します。
// そのため、SharedPreferencesWrapperをMock化します。
// もしSharedPreferencesAsync自体がインターフェースであれば、SharedPreferencesAsyncをMock化します。
class MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync {}

void main() {
  late MockSharedPreferencesAsync mockPrefs;
  late SharedPreferencesRepository repository;

  // 各テストケースの前に実行
  setUp(() {
    mockPrefs = MockMockSharedPreferencesAsync();
    // SharedPreferencesRepositoryのコンストラクタにはmockPrefsを渡します
    repository = SharedPreferencesRepository(mockPrefs);
  });

  group('SharedPreferencesRepository', () {
    // --- getSettingDataのテスト ---
    test('getSettingData: 保存されている設定値を正しく取得できること', () async {
      // Mockの振る舞いを定義: getStringとgetBoolがそれぞれ特定の値を返すように設定
      when(mockPrefs.getString('sort')).thenAnswer((_) async => 'id');
      when(mockPrefs.getBool('notification')).thenAnswer((_) async => true);

      // テスト対象のメソッドを呼び出し
      final settingModel = await repository.getSettingData();

      // 結果の検証
      expect(settingModel.sortData, 'id');
      expect(settingModel.isNotification, true);

      // Mockのメソッドが期待通りに呼び出されたことを検証
      verify(mockPrefs.getString('sort')).called(1);
      verify(mockPrefs.getBool('notification')).called(1);
    });

    test('getSettingData: 設定値が保存されていない場合にnullを返すこと', () async {
      // Mockの振る舞いを定義: getStringとgetBoolがnullを返すように設定
      when(mockPrefs.getString('sort')).thenAnswer((_) async => null);
      when(mockPrefs.getBool('notification')).thenAnswer((_) async => null);

      // テスト対象のメソッドを呼び出し
      final settingModel = await repository.getSettingData();

      // 結果の検証
      expect(settingModel.sortData, null);
      expect(settingModel.isNotification, null);

      verify(mockPrefs.getString('sort')).called(1);
      verify(mockPrefs.getBool('notification')).called(1);
    });

    group('fromSetting', () {
      test('fromSetting: SettingからSettingModelへ正しく変換できること', () {
        final setting = Setting(
          sortData: 'expirationDate',
          isNotification: true,
        );

        final settingModel = repository.fromSetting(setting);

        expect(settingModel.sortData, 'expirationDate');
        expect(settingModel.isNotification, true);
      });
    });
  });
}
