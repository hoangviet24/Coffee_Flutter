// ignore_for_file: file_names, use_build_context_synchronously

import 'package:coffee/Order/orderSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/CartModel.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isSnackBarVisible = false;
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
                        trailing: IconButton(
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
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tổng tiền: \$${cart.totalPrice.toStringAsFixed(2)}',
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
            child: ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            // ignore: prefer_const_constructors
                            builder: (context) => OrderSelectionPage()),
                      );
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Thanh toán',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
