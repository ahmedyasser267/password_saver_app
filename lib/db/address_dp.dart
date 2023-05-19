import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/address_model.dart';


class DBHelperc2 {
  static final DBHelperc2 _instance = DBHelperc2._internal();
  factory DBHelperc2() => _instance;
  DBHelperc2._internal();

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
    final path = join(dbPath, 'contact_database.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, address TEXT)",
      );
    });
  }

  Future<List<Map<String, dynamic>>> queryContacts() async {
    final db = await database;
    return await db.query("contacts");
  }

  Future<int> insertContact(Contact? contact) async {
    final db = await database;
    print('Insert ====');

    return await db.insert('contacts', contact!.toMap());
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete(
      "contacts",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllContacts() async {
    final db = await database;
    await db.delete("contacts");
  }

  Future<void> updateContact(Contact? contact) async {
    final db = await database;
    await db.update(
      "contacts",
      contact!.toMap(),
      where: "id = ?",
      whereArgs: [contact.id],
    );
  }
}
