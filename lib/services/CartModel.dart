import 'package:coffee/Data/Product.dart';
import 'package:coffee/services/histories_cart.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartModel extends ChangeNotifier {
  late Database _db;
  List<Product> _items = [];
  final HistoryDatabase _historyDatabase = HistoryDatabase();
  List<Product> get items => _items;

  Future<void> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cart_database.db');

    _db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          """
        CREATE TABLE Cart(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT, 
          title TEXT, 
          money REAL, 
          path TEXT)
          """,
        );
      },
      version: 1,
    );
    await loadCart(); // Chỉ gọi loadCart() khi cơ sở dữ liệu đã được khởi tạo
  }

  Future<void> loadCart() async {
    try {
      final db = await _db; // Lấy instance của database
      final List<Map<String, dynamic>> maps =
          await db.query('Cart'); // Truy vấn dữ liệu từ bảng Cart

      _items = List.generate(maps.length, (i) {
        // Chuyển đổi thành các đối tượng Product
        return Product(
          name: maps[i]['name'],
          title: maps[i]['title'],
          money: maps[i]['money'],
          path: maps[i]['path'],
        );
      });
      notifyListeners(); // Thông báo thay đổi dữ liệu
    } catch (e) {
      print('Error loading cart: $e'); // In lỗi nếu có
    }
  }

  Future<void> add(Product product) async {
    await _db.insert(
      'Cart',
      {
        'name': product.name,
        'title': product.title,
        'money': product.money,
        'path': product.path,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _items.add(product);
    notifyListeners();
  }

  Future<void> remove(int index) async {
    final product = _items[index];
    await _db.delete(
      'Cart',
      where: 'name = ? AND title = ? AND money = ? AND path = ? ',
      whereArgs: [
        product.name,
        product.title,
        product.money,
        product.path,
      ],
    );
    _items.removeAt(index);
    notifyListeners();
  }

  Future<void> clear() async {
    if (_items.isEmpty) return;

    // Thêm dữ liệu vào lịch sử
    for (var item in _items) {
      await _historyDatabase.insertHistory(
        HistoryModel(
            name: item.name,
            money: item.money,
            path: item.path,
          title: item.title
        ),
      );
    }

    // Xóa giỏ hàng
    await _db.delete('Cart');
    _items.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.money;
    }
    return total;
  }
}
