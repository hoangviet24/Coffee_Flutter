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
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    _items = List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        name: maps[i]['name'],
        path: maps[i]['path'],
        title: maps[i]['title'],
        money: maps[i]['money'],
        isSelected: maps[i]['isSelected'] == 1,
      );
    });
    notifyListeners();
  }

  void add(Product product) {
    final existingProductIndex = _items.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      // Cập nhật trạng thái sản phẩm nếu đã tồn tại
      _items[existingProductIndex] =
          product.copyWith(isSelected: _items[existingProductIndex].isSelected);
    } else {
      // Thêm sản phẩm mới nếu chưa tồn tại
      _items.add(product.copyWith(id: _generateUniqueId()));
    }
    saveCartState();
    notifyListeners();
  }

  int _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch;
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
    final selectedItems = _items.where((item) => item.isSelected).toList();

    if (selectedItems.isEmpty) return;

    // Thêm dữ liệu vào lịch sử
    for (var item in selectedItems) {
      await _historyDatabase.insertHistory(
        HistoryModel(
          id: item.id,
          name: item.name,
          money: item.money,
          path: item.path,
          title: item.title,
        ),
      );
    }

    // Xóa chỉ những sản phẩm đã được chọn
    for (var item in selectedItems) {
      await _db.delete(
        'Cart',
        where: 'name = ? AND title = ? AND money = ? AND path = ? ',
        whereArgs: [
          item.name,
          item.title,
          item.money,
          item.path,
        ],
      );
    }

    _items.removeWhere(
        (item) => item.isSelected); // Xóa những sản phẩm đã chọn từ danh sách
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.money;
    }
    return total;
  }

  double get totalSelectedPrice {
    return items
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.money);
  }

  void updateSelection(int productId, bool isSelected) {
    final index = _items.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(isSelected: isSelected);
      saveCartState(); // Lưu trạng thái vào cơ sở dữ liệu
      notifyListeners();
    }
  }

  Future<void> saveCartState() async {
    final db = await _db;
    // Xóa tất cả sản phẩm hiện tại trong cơ sở dữ liệu
    await db.delete('cart');

    // Lưu từng sản phẩm vào cơ sở dữ liệu
    for (final item in _items) {
      await db.insert(
        'cart',
        item.toMap(), // Chắc chắn rằng Product có phương thức toMap() phù hợp
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
