// ignore_for_file: use_build_context_synchronously

import 'package:coffee/pages/Home/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/CartModel.dart';

class QRScreen extends StatelessWidget {
  final double totalPrice;

  const QRScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final qrData = 'Total Price: \$${totalPrice.toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR Thanh Toán'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero, // Loại bỏ padding nếu có
          children: [
            Container(
              color:
                  Colors.white, // Thay đổi màu nền của container chứa hình ảnh
              child: Image(image: AssetImage('assets/QR.png')),
            ),
            Text(
              qrData,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                final cartModel =
                    Provider.of<CartModel>(context, listen: false);
                await cartModel.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const firstpage()),
                );
              },
              child: const Text('Hoàn thành'),
            )
          ],
        ),
      ),
    );
  }
}
