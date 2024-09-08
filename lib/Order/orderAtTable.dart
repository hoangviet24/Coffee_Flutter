import 'package:coffee/Data/Product.dart';
import 'package:coffee/pages/Manage/QR.dart';
import 'package:flutter/material.dart';

class OrderTablePage extends StatefulWidget {
  final double totalPrice;
  final List<Product> selectedItems;
  const OrderTablePage(
      {required this.totalPrice, super.key, required this.selectedItems});

  @override
  _OrderTablePageState createState() => _OrderTablePageState();
}

class _OrderTablePageState extends State<OrderTablePage> {
  int? _selectedTableNumber;
  final TextEditingController _reminderController = TextEditingController();
  bool _isSnackBarVisible = false;
  @override
  void dispose() {
    _reminderController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_selectedTableNumber == null) {
      if (!_isSnackBarVisible) {
        _isSnackBarVisible = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(
                content: Text('Vui lòng chọn số bàn'),
                duration: Duration(seconds: 1),
              ),
            )
            .closed
            .then((_) {
          _isSnackBarVisible = false;
        });
      }
      return;
    }

    final totalSelectedPrice = widget.selectedItems
        .fold(0.0, (sum, item) => sum + item.money); // Tính tổng giá

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScreen(
          totalPrice: totalSelectedPrice,
          selectedItems:
              widget.selectedItems, // Truyền danh sách sản phẩm đã chọn
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt hàng tại bàn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Số bàn',
                border: OutlineInputBorder(),
              ),
              value: _selectedTableNumber,
              items: List.generate(20, (index) => index + 1).map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('Bàn $value'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTableNumber = value;
                });
              },
              menuMaxHeight: 200.0,
              hint: const Text('Chọn số bàn'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _reminderController,
              decoration: const InputDecoration(
                labelText: 'Nhắc nhở',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitOrder,
              child: const Text('Gửi đơn'),
            ),
          ],
        ),
      ),
    );
  }
}
