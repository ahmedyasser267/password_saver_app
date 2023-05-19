import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/address_model.dart';
import '../models/web.dart';

class DBHelperc3 {
  static final DBHelperc3 _instance = DBHelperc3._internal();
  factory DBHelperc3() => _instance;
  DBHelperc3._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await initDb();
    if (_db!.isOpen) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'web.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)",
      );
    });
  }

  Future<List<Map<String, dynamic>>> queryContacts() async {
    final db = await database;
    return await db.query("users");
  }



  Future<List<Map<String, dynamic>>> queryWeb() async {
    final db = await database;
    return await db.query("users");
  }

  Future<int> insertWeb(Web? web) async {
    final db = await database;
    print('Insert ====');

    return await db.insert('users', web!.toMap());
  }

  Future<void> deleteWeb(int id) async {
    final db = await database;
    await db.delete(
      "users",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllWeb() async {
    final db = await database;
    await db.delete("users");
  }

  Future<void> updateWeb(Web? web) async {
    final db = await database;
    await db.update(
      "users",
      web!.toMap(),
      where: "id = ?",
      whereArgs: [web.id],
    );
  }
}
