import 'package:food_limmit_controller/data/repository/shared_preferences/IF_shared_preferences_repository.dart';
import 'package:food_limmit_controller/data/repository/shared_preferences/shared_preferences_repository.dart';
import 'package:food_limmit_controller/data/service/shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'IF_shared_preferences_repository_provider.g.dart';

@riverpod
IFSharedPreferencesRepository sharedPreferencesRepository(Ref ref) {
  final database = ref.watch(sharedPreferencesAsyncModelProvider);
  return SharedPreferencesRepository(database);
}
