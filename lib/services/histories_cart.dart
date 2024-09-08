import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryModel {
  final int id;
  final String name;
  final String path;
  final String title;
  final double money;
  HistoryModel(
      {required this.id,
      required this.name,
      required this.money,
      required this.path,
      required this.title});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'money': money,
      'path': path,
      'title': title
    };
  }

  Product toProduct() {
    return Product(
      id: id,
      name: name,
      title: title,
      money: money,
      path: path,
    );
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
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

  Future<bool> _historyExists(HistoryModel history) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'history',
      where: 'name = ? AND title = ? AND money = ? AND path = ?',
      whereArgs: [
        history.name,
        history.title,
        history.money,
        history.path,
      ],
    );
    return maps.isNotEmpty;
  }

  Future<void> insertHistory(HistoryModel history) async {
    final exists = await _historyExists(history);
    if (!exists) {
      final db = await database;
      await db.insert(
        'history',
        history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      notifyListeners();
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');
    return List.generate(maps.length, (i) {
      return HistoryModel(
          id: maps[i]['id'],
          name: maps[i]['name'],
          money: maps[i]['money'],
          path: maps[i]['path'],
          title: maps[i]['title']);
    });
  }
}
