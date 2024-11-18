// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDatetimeMeta =
      const VerificationMeta('createDatetime');
  @override
  late final GeneratedColumn<DateTime> createDatetime =
      GeneratedColumn<DateTime>('create_datetime', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, index, content, createDatetime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('create_datetime')) {
      context.handle(
          _createDatetimeMeta,
          createDatetime.isAcceptableOrUnknown(
              data['create_datetime']!, _createDatetimeMeta));
    } else if (isInserting) {
      context.missing(_createDatetimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createDatetime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}create_datetime'])!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final int index;
  final String content;
  final DateTime createDatetime;
  const Todo(
      {required this.id,
      required this.index,
      required this.content,
      required this.createDatetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['index'] = Variable<int>(index);
    map['content'] = Variable<String>(content);
    map['create_datetime'] = Variable<DateTime>(createDatetime);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      index: Value(index),
      content: Value(content),
      createDatetime: Value(createDatetime),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      index: serializer.fromJson<int>(json['index']),
      content: serializer.fromJson<String>(json['content']),
      createDatetime: serializer.fromJson<DateTime>(json['createDatetime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'index': serializer.toJson<int>(index),
      'content': serializer.toJson<String>(content),
      'createDatetime': serializer.toJson<DateTime>(createDatetime),
    };
  }

  Todo copyWith(
          {int? id, int? index, String? content, DateTime? createDatetime}) =>
      Todo(
        id: id ?? this.id,
        index: index ?? this.index,
        content: content ?? this.content,
        createDatetime: createDatetime ?? this.createDatetime,
      );
  Todo copyWithCompanion(TodosCompanion data) {
    return Todo(
      id: data.id.present ? data.id.value : this.id,
      index: data.index.present ? data.index.value : this.index,
      content: data.content.present ? data.content.value : this.content,
      createDatetime: data.createDatetime.present
          ? data.createDatetime.value
          : this.createDatetime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('index: $index, ')
          ..write('content: $content, ')
          ..write('createDatetime: $createDatetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, index, content, createDatetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.index == this.index &&
          other.content == this.content &&
          other.createDatetime == this.createDatetime);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<int> index;
  final Value<String> content;
  final Value<DateTime> createDatetime;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.index = const Value.absent(),
    this.content = const Value.absent(),
    this.createDatetime = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required int index,
    required String content,
    required DateTime createDatetime,
  })  : index = Value(index),
        content = Value(content),
        createDatetime = Value(createDatetime);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<int>? index,
    Expression<String>? content,
    Expression<DateTime>? createDatetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (index != null) 'index': index,
      if (content != null) 'content': content,
      if (createDatetime != null) 'create_datetime': createDatetime,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<int>? index,
      Value<String>? content,
      Value<DateTime>? createDatetime}) {
    return TodosCompanion(
      id: id ?? this.id,
      index: index ?? this.index,
      content: content ?? this.content,
      createDatetime: createDatetime ?? this.createDatetime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createDatetime.present) {
      map['create_datetime'] = Variable<DateTime>(createDatetime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('index: $index, ')
          ..write('content: $content, ')
          ..write('createDatetime: $createDatetime')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}

typedef $$TodosTableCreateCompanionBuilder = TodosCompanion Function({
  Value<int> id,
  required int index,
  required String content,
  required DateTime createDatetime,
});
typedef $$TodosTableUpdateCompanionBuilder = TodosCompanion Function({
  Value<int> id,
  Value<int> index,
  Value<String> content,
  Value<DateTime> createDatetime,
});

class $$TodosTableFilterComposer extends Composer<_$Database, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createDatetime => $composableBuilder(
      column: $table.createDatetime,
      builder: (column) => ColumnFilters(column));
}

class $$TodosTableOrderingComposer extends Composer<_$Database, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createDatetime => $composableBuilder(
      column: $table.createDatetime,
      builder: (column) => ColumnOrderings(column));
}

class $$TodosTableAnnotationComposer extends Composer<_$Database, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createDatetime => $composableBuilder(
      column: $table.createDatetime, builder: (column) => column);
}

class $$TodosTableTableManager extends RootTableManager<
    _$Database,
    $TodosTable,
    Todo,
    $$TodosTableFilterComposer,
    $$TodosTableOrderingComposer,
    $$TodosTableAnnotationComposer,
    $$TodosTableCreateCompanionBuilder,
    $$TodosTableUpdateCompanionBuilder,
    (Todo, BaseReferences<_$Database, $TodosTable, Todo>),
    Todo,
    PrefetchHooks Function()> {
  $$TodosTableTableManager(_$Database db, $TodosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> index = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createDatetime = const Value.absent(),
          }) =>
              TodosCompanion(
            id: id,
            index: index,
            content: content,
            createDatetime: createDatetime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int index,
            required String content,
            required DateTime createDatetime,
          }) =>
              TodosCompanion.insert(
            id: id,
            index: index,
            content: content,
            createDatetime: createDatetime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TodosTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $TodosTable,
    Todo,
    $$TodosTableFilterComposer,
    $$TodosTableOrderingComposer,
    $$TodosTableAnnotationComposer,
    $$TodosTableCreateCompanionBuilder,
    $$TodosTableUpdateCompanionBuilder,
    (Todo, BaseReferences<_$Database, $TodosTable, Todo>),
    Todo,
    PrefetchHooks Function()>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
}
