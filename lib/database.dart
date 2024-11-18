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