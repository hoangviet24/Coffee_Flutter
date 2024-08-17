import 'package:coffee/pages/Manage/QR.dart';
import 'package:flutter/material.dart';

class OrderTablePage extends StatefulWidget {
  final double totalPrice;

  const OrderTablePage({
    required this.totalPrice,
    super.key,
  });

  @override
  _OrderTablePageState createState() => _OrderTablePageState();
}

class _OrderTablePageState extends State<OrderTablePage> {
  final TextEditingController _tableNumberController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();

  @override
  void dispose() {
    _tableNumberController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    final tableNumber = _tableNumberController.text;
    final reminder = _reminderController.text;

    if (tableNumber.isEmpty || reminder.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số bàn và nhắc nhở')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScreen(
          totalPrice: widget.totalPrice,
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
            TextField(
              controller: _tableNumberController,
              decoration: const InputDecoration(
                labelText: 'Số bàn',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
