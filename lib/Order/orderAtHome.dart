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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRScreen(
            totalPrice: widget.totalPrice,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt hàng về nhà'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Đảm bảo các trường chiếm toàn bộ chiều rộng
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên người dùng';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  final phoneRegExp = RegExp(r'^(?:[+0]9)?[0-9]{10,12}$');
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Vui lòng nhập số điện thoại hợp lệ';
                  }
                  return null;
                },
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
      ),
    );
  }
}
