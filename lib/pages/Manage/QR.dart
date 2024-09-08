import 'package:coffee/pages/Home/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';

class QRScreen extends StatelessWidget {
  final double totalPrice;
  final List<Product> selectedItems; // Thêm thuộc tính selectedItems

  const QRScreen({
    super.key,
    required this.totalPrice,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = 'Total Price: \$${totalPrice.toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR Thanh Toán'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Image(image: AssetImage('assets/QR.png')),
            ),
            const SizedBox(height: 16.0),
            Text(
              qrData,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            if (selectedItems.isNotEmpty) ...[
              const Text(
                'Danh sách sản phẩm:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    final item = selectedItems[index];
                    return ListTile(
                      leading: Image.asset(
                        item.path,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.title),
                      subtitle: Text('\$${item.money.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final cartModel =
                    Provider.of<CartModel>(context, listen: false);
                await cartModel.clear();

                // Hiển thị thông báo thành công
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanh toán thành công'),
                      content: const Text('Cảm ơn bạn đã mua hàng!'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Đóng hộp thoại
                            // Điều hướng về trang đầu tiên sau khi đóng
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const firstpage()),
                              (route) =>
                                  false, // Loại bỏ tất cả các trang hiện tại khỏi stack
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
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
