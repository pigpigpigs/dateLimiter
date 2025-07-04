// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ItemTableTable extends ItemTable
    with TableInfo<$ItemTableTable, ItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, expirationDate, imagePath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
      imagePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_path'],
          )!,
    );
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(attachedDatabase, alias);
  }
}

class ItemTableData extends DataClass implements Insertable<ItemTableData> {
  final int id;
  final DateTime? expirationDate;
  final String imagePath;
  const ItemTableData({
    required this.id,
    this.expirationDate,
    required this.imagePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    map['image_path'] = Variable<String>(imagePath);
    return map;
  }

  ItemTableCompanion toCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      id: Value(id),
      expirationDate:
          expirationDate == null && nullToAbsent
              ? const Value.absent()
              : Value(expirationDate),
      imagePath: Value(imagePath),
    );
  }

  factory ItemTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTableData(
      id: serializer.fromJson<int>(json['id']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  ItemTableData copyWith({
    int? id,
    Value<DateTime?> expirationDate = const Value.absent(),
    String? imagePath,
  }) => ItemTableData(
    id: id ?? this.id,
    expirationDate:
        expirationDate.present ? expirationDate.value : this.expirationDate,
    imagePath: imagePath ?? this.imagePath,
  );
  ItemTableData copyWithCompanion(ItemTableCompanion data) {
    return ItemTableData(
      id: data.id.present ? data.id.value : this.id,
      expirationDate:
          data.expirationDate.present
              ? data.expirationDate.value
              : this.expirationDate,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableData(')
          ..write('id: $id, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, expirationDate, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTableData &&
          other.id == this.id &&
          other.expirationDate == this.expirationDate &&
          other.imagePath == this.imagePath);
}

class ItemTableCompanion extends UpdateCompanion<ItemTableData> {
  final Value<int> id;
  final Value<DateTime?> expirationDate;
  final Value<String> imagePath;
  const ItemTableCompanion({
    this.id = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  ItemTableCompanion.insert({
    this.id = const Value.absent(),
    this.expirationDate = const Value.absent(),
    required String imagePath,
  }) : imagePath = Value(imagePath);
  static Insertable<ItemTableData> custom({
    Expression<int>? id,
    Expression<DateTime>? expirationDate,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  ItemTableCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? expirationDate,
    Value<String>? imagePath,
  }) {
    return ItemTableCompanion(
      id: id ?? this.id,
      expirationDate: expirationDate ?? this.expirationDate,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableCompanion(')
          ..write('id: $id, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ItemTableTable itemTable = $ItemTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [itemTable];
}

typedef $$ItemTableTableCreateCompanionBuilder =
    ItemTableCompanion Function({
      Value<int> id,
      Value<DateTime?> expirationDate,
      required String imagePath,
    });
typedef $$ItemTableTableUpdateCompanionBuilder =
    ItemTableCompanion Function({
      Value<int> id,
      Value<DateTime?> expirationDate,
      Value<String> imagePath,
    });

class $$ItemTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemTableTable> {
  $$ItemTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ItemTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemTableTable> {
  $$ItemTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemTableTable> {
  $$ItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);
}

class $$ItemTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemTableTable,
          ItemTableData,
          $$ItemTableTableFilterComposer,
          $$ItemTableTableOrderingComposer,
          $$ItemTableTableAnnotationComposer,
          $$ItemTableTableCreateCompanionBuilder,
          $$ItemTableTableUpdateCompanionBuilder,
          (
            ItemTableData,
            BaseReferences<_$AppDatabase, $ItemTableTable, ItemTableData>,
          ),
          ItemTableData,
          PrefetchHooks Function()
        > {
  $$ItemTableTableTableManager(_$AppDatabase db, $ItemTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ItemTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ItemTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
              }) => ItemTableCompanion(
                id: id,
                expirationDate: expirationDate,
                imagePath: imagePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                required String imagePath,
              }) => ItemTableCompanion.insert(
                id: id,
                expirationDate: expirationDate,
                imagePath: imagePath,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemTableTable,
      ItemTableData,
      $$ItemTableTableFilterComposer,
      $$ItemTableTableOrderingComposer,
      $$ItemTableTableAnnotationComposer,
      $$ItemTableTableCreateCompanionBuilder,
      $$ItemTableTableUpdateCompanionBuilder,
      (
        ItemTableData,
        BaseReferences<_$AppDatabase, $ItemTableTable, ItemTableData>,
      ),
      ItemTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemTableTableTableManager get itemTable =>
      $$ItemTableTableTableManager(_db, _db.itemTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'18ce5c8c4d8ddbfe5a7d819d8fb7d5aca76bf416';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = AutoDisposeProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
