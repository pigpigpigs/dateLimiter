import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:food_limmit_controller/data/service/model/item/item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_database.g.dart';

class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  TextColumn get imagePath => text()();
}

@DriftDatabase(tables: [ItemTable])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
