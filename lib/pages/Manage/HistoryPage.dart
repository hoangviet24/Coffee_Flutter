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
                  title: Text(item.name),
                  subtitle: Text('Giá: \$${item.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final historyDb =
                          Provider.of<HistoryDatabase>(context, listen: false);
                      await historyDb
                          .deleteHistory(item.name); // Xóa item khỏi DB

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã xóa ${item.name} khỏi lịch sử'),
                          duration: const Duration(milliseconds: 200),
                        ),
                      );

                      _refreshHistory(); // Cập nhật lại lịch sử sau khi xóa
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
