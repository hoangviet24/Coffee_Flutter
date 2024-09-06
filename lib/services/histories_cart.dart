import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryModel {
  final String name;
  final String path;
  final String title;
  final double money;
  HistoryModel(
      {required this.name,
      required this.money,
      required this.path,
      required this.title });
  Map<String, dynamic> toMap() {
    return {'name': name, 'money': money, 'path':path,'title':title};
  }
  Product toProduct() {
    return Product(
      name: name,
      title: title,
      money: money,
      path: path,
    );
  }
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      name: map['name'],
      path: map['path'],
      title: map['title'],
      money: (map['money'] as int).toDouble(),
    );
  }
}

class HistoryDatabase extends ChangeNotifier {
  static final HistoryDatabase _instance = HistoryDatabase._internal();
  factory HistoryDatabase() => _instance;
  final List<HistoryModel> _items = [];
  List<HistoryModel> get items => _items;
  HistoryDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'history_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, name TEXT, money REAL,path TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertHistory(HistoryModel history) async {
    final db = await database;
    await db.insert(
      'history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<HistoryModel>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');
    return List.generate(maps.length, (i) {
      return HistoryModel(
          name: maps[i]['name'],
          money: maps[i]['money'],
          path: maps[i]['path'],
        title: maps[i]['title']
      );
    });
  }

  Future<void> deleteHistory(String name) async {
    final db = await database;
    await db.delete(
      'history',
      where: 'name = ?',
      whereArgs: [name],
    );
    notifyListeners();
  }
}
