import 'package:coffee/Data/Product.dart';
import 'package:coffee/Order/orderAtHome.dart';
import 'package:coffee/Order/orderAtTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/CartModel.dart';

class OrderSelectionPage extends StatelessWidget {
  final List<Product> selectedItems; // Thêm thuộc tính selectedItems

  const OrderSelectionPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn loại đơn hàng'),
        centerTitle: true,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildOrderOption(
                    context,
                    'Đặt hàng tại bàn',
                    Icons.table_chart,
                    OrderTablePage(
                      totalPrice: cart.totalPrice,
                      selectedItems: selectedItems,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildOrderOption(
                    context,
                    'Đặt hàng về nhà',
                    Icons.home,
                    OrderHomePage(
                      totalPrice: cart.totalPrice,
                      selectedItems: selectedItems,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderOption(
    BuildContext context,
    String title,
    IconData icon,
    Widget nextPage,
  ) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
      ),
    );
  }
}
