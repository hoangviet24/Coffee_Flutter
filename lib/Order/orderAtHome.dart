import 'package:coffee/pages/Manage/QR.dart';
import 'package:flutter/material.dart';

class OrderHomePage extends StatefulWidget {
  final double totalPrice;

  const OrderHomePage({
    required this.totalPrice,
    super.key,
  });

  @override
  _OrderHomePageState createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    final name = _nameController.text;
    final address = _addressController.text;
    final reminder = _reminderController.text;

    if (name.isEmpty || address.isEmpty || reminder.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
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
        title: const Text('Đặt hàng về nhà'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Địa chỉ',
                border: OutlineInputBorder(),
              ),
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
