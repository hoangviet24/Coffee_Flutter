import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: taskCake(),
    ),
  ));
}

class taskCake extends StatefulWidget {
  const taskCake({super.key});

  @override
  State<taskCake> createState() => _taskCakeState();
}

class _taskCakeState extends State<taskCake> {
  bool _isSnackBarVisible = false;
  final List<Product> products = [
    Product(
        id: 26,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 27,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 28,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 29,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 30,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 31,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 32,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
    Product(
        id: 33,
        name: "Americano",
        path: 'assets/Americano.png',
        title: "Americano Coffee",
        money: 25000),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        for (var i = 0; i < products.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCoffeeItem(products[i]),
              ),
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
              id: product.id,
              imageName: product.name,
              imagePath: product.path,
              title: product.title,
              money: product.money,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 253, 253, 253),
                image: DecorationImage(
                  image: AssetImage(product.path),
                  fit: BoxFit.cover,
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontFamily: 'EduAUVICWANTHand',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${product.money}',
                    style: const TextStyle(
                      fontFamily: 'EduAUVICWANTHand',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
