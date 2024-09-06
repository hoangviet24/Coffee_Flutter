import 'package:coffee/services/CartModel.dart';
import 'package:coffee/services/histories_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<HistoryModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _refreshHistory(); // Lấy lịch sử ban đầu
  }

  void _refreshHistory() {
    final historyDb = Provider.of<HistoryDatabase>(context, listen: false);
    setState(() {
      _historyFuture = historyDb.getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử Thanh Toán'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<HistoryModel>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có lịch sử thanh toán'));
          } else {
            final historyItems = snapshot.data!;
            return ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];

                return ListTile(
                  leading: Image.asset(
                    item.path,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text('Giá: \$${item.money.toStringAsFixed(2)}'),
                  trailing: Consumer<CartModel>(
                    builder: (context, cartModel, child) {
                      return IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          // Chuyển đổi từ HistoryModel sang Product trước khi thêm vào giỏ hàng
                          final product = item.toProduct();
                          cartModel.add(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Đã thêm ${item.name} vào giỏ hàng'),
                              duration: const Duration(milliseconds: 200),
                            ),
                          );
                          _refreshHistory();
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
