import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String usersTable = 'users_table';
  String colId = 'id';
  String colName = 'name';
  String colEmail = 'email';
  String colPassword = 'password';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, 'app.db');
    final tasksDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return tasksDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $usersTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colEmail TEXT, $colPassword TEXT)');
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(usersTable);
    return result;
  }

  /*
  handel
   */
  Future<List<User>> getUserList() async {
    final List<Map<String, dynamic>> userMapList = await getUserMapList();
    final List<User> userList = [];
    userMapList.forEach((userMap) {
      userList.add(User.fromMap(userMap));
    });
    return userList;
  }

  Future<int> insertUser(User user) async {
    Database db = await this.db;
    final int result = await db.insert(usersTable, user.toMap());
    return result;
  }

  Future<int> updateUser(User user) async {
    Database db = await this.db;
    final int result = await db.update(usersTable, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database db = await this.db;
    final int result =
    await db.delete(usersTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}

class User {
  int? id;
  String name;
  String email;
  String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
