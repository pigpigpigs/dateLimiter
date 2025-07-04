import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
class SharedPreferencesAsyncModel extends _$SharedPreferencesAsyncModel {
  @override
  SharedPreferencesAsync build() {
    return init();
  }

  SharedPreferencesAsync init() {
    return SharedPreferencesAsync();
  }
}
