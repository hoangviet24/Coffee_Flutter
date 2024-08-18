import 'package:coffee/Data/Product.dart';
import 'package:coffee/services/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: taskJuice(),
    ),
  ));
}

class taskJuice extends StatefulWidget {
  const taskJuice({super.key});

  @override
  State<taskJuice> createState() => _taskJuiceState();
}

class _taskJuiceState extends State<taskJuice> {
  bool _isSnackBarVisible = false;
  final List<Product> products = [
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        name: "Americano",
        path: 'assets/nuocep.png',
        title: "Americano Coffee",
        money: 25000),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < products.length; i += 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCoffeeItem(products[i]),
              if (i + 1 < products.length) _buildCoffeeItem(products[i + 1]),
            ],
          ),
      ],
    );
  }

  Widget _buildCoffeeItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              imageName: product.name,
              imagePath: product.path,
              title: product.title,
              money: product.money,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(255, 253, 253, 253),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 10, 3, 3).withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(product.path), // Sử dụng đúng tên hình ảnh
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      final cart =
                          Provider.of<CartModel>(context, listen: false);
                      cart.add(product);
                      if (!_isSnackBarVisible) {
                        _isSnackBarVisible = true;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${product.name} đã được thêm vào giỏ hàng'),
                                duration: Duration(milliseconds: 200),
                              ),
                            )
                            .closed
                            .then((_) {
                          _isSnackBarVisible = false;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(218, 248, 247, 247),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 2, 2, 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            product.name,
            style: const TextStyle(
              fontFamily: 'EduAUVICWANTHand',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}
