import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/card.dart';

class DBHelperc {
  static final DBHelperc _instance = DBHelperc._internal();
  factory DBHelperc() => _instance;
  DBHelperc._internal();

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
    final path = join(dbPath, "card_database.db");

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE cards(id INTEGER PRIMARY KEY, name TEXT, cardNumber TEXT, pin TEXT, password TEXT)",
      );
    });
  }

  Future<List<Map<String, dynamic>>> queryCards() async {
    final db = await database;
    return await db.query("cards");
  }

  Future<int> insertCard(MyCard? card) async {
    final db = await database;
    print('Insert ====');

    return await db.insert('cards', card!.toMap());
  }

  Future<void> deleteCard(int id) async {
    final db = await database;
    await db.delete(
      "cards",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllCards() async {
    final db = await database;
    await db.delete("cards");
  }

  Future<void> updateCard(MyCard? card) async {
    final db = await database;
    await db.update(
      "cards",
      card!.toMap(),
      where: "id = ?",
      whereArgs: [card.id],
    );
  }
}
