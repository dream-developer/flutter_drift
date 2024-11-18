import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
part 'database.g.dart'; // ファイル名.g.dart

class Todos extends Table{ // 1
  IntColumn get id => integer().autoIncrement()(); // 2
  IntColumn get index => integer()(); // 3
  TextColumn get content => text()(); // 4
  DateTimeColumn get createDatetime => dateTime()(); // 5
}

@DriftDatabase(tables: [Todos])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
   Future insertTodo(String content,DateTime createDatetime) { // 1
    return into(todos).insert(TodosCompanion.insert(index: 0, content: content, createDatetime: createDatetime));
  }

  Future deleteTodo(int id) { // 2
    return (delete(todos)..where((todo) => todo.id.equals(id))).go();
  }

  Future updateTodo(int id, String content) { // 3
    return (update(todos)..where((todo) => todo.id.equals(id)))
        .write(TodosCompanion(content: Value(content)));
  }  

  Stream<List<Todo>> watchEntries() { // 4
    // return (select(todos)).watch();
    return (select(todos)..orderBy([
     (todos) => OrderingTerm(expression: todos.index, mode: OrderingMode.desc)
    ])).watch();
  }

  Future<Todo> getTodo(int id) async { // 5
    final todo = await (select(todos)..where((todo) => todo.id.equals(id))).getSingle();
    return todo;
  }

  //【index(並び順)関連】 --------------------------------------------
  // 新規レコード作成時にindex をid -1 とする用。
  Future updateIndex_id1(int id) { // 6
    return (update(todos)..where((todo) => todo.id.equals(id)))
        .write(TodosCompanion(index: Value(id -1)));
  }
  // indexの交換。
  Future updateChangeIndex(int id_1,int index_1, int id_2,int index_2) { // 7
    (update(todos)..where((todo) => todo.id.equals(id_1)))
        .write(TodosCompanion(index: Value(index_2)));
    return (update(todos)..where((todo) => todo.id.equals(id_2)))
        .write(TodosCompanion(index: Value(index_1)));
  }
}
LazyDatabase _openConnection() { // 1
  return LazyDatabase(() async {
    final dbFloder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFloder.path, 'db.sqlite'));
    if (Platform.isAndroid) { // 2
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}