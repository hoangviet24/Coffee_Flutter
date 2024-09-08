import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Order/orderSelection.dart';
import 'package:coffee/services/database_helper.dart';
import 'package:coffee/Data/User.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isSnackBarVisible = false;
  late Future<Users?> _currentUserFuture;

  @override
  void initState() {
    super.initState();
    _currentUserFuture = DatabaseHelper().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có sản phẩm',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.asset(
                          item.path,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.name),
                        subtitle: Text(item.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: item.isSelected,
                              onChanged: (bool? value) {
                                // Cập nhật trạng thái chọn của sản phẩm
                                cart.updateSelection(item.id, value ?? false);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await cart.remove(index);
                                if (!_isSnackBarVisible) {
                                  _isSnackBarVisible = true;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text('Sản phẩm đã được xóa'),
                                          duration: Duration(milliseconds: 200),
                                        ),
                                      )
                                      .closed
                                      .then((_) {
                                    _isSnackBarVisible = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tổng tiền: \$${cart.totalSelectedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _currentUserFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Đang kiểm tra...',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final selectedItems =
                      cart.items.where((item) => item.isSelected).toList();

                  return ElevatedButton(
                    onPressed: selectedItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSelectionPage(
                                  selectedItems: selectedItems,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Đặt Hàng',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Thông báo"),
                            content: Text("Hãy đăng nhập để thanh toán."),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Đặt Hàng',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
