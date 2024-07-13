import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    print("initializing");
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'users.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldv, int newv) async {
    await db.execute("ALTER TABLE users ADD image TEXT NULL");
    print("upgraded");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "users" (
      "id" INTEGER PRIMARY KEY,
      "name" TEXT NOT NULL,
      "password"  TEXT NOT NULL,
      "gender" TEXT,
      "level" INTEGER,
      "email" TEXT NOT NULL
    )
''');

    print("created database ======");
  }

  Future<List<Map>> readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
