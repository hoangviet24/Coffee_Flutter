import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryModel {
  final String name;
  final double price;

  HistoryModel({required this.name, required this.price});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
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
          "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL)",
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
        price: maps[i]['price'],
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
