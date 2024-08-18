// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_string_interpolations

import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:provider/provider.dart';

void main() => const Other();

class Other extends StatefulWidget {
  const Other({super.key});

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {
  bool _isSnackBarVisible = false;
  @override
  Widget build(BuildContext context) {
    // Danh sách các sản phẩm
    List<Product> products = [
      Product(
          name: "Americano",
          title: "Rich Americano",
          money: 1000,
          path: 'assets/1.png'),
      Product(
          name: "Robusta",
          title: "Bold Robusta",
          money: 1200,
          path: 'assets/1.png'),
      Product(
          name: "Kopi Luwak",
          title: "Exotic Kopi Luwak",
          money: 2000,
          path: 'assets/1.png'),
      Product(
          name: "Arabica",
          title: "Smooth Arabica",
          money: 1500,
          path: 'assets/1.png'),
      Product(
          name: "Cherry",
          title: "Sweet Cherry",
          money: 1100,
          path: 'assets/1.png'),
      Product(
          name: "Bourbon",
          title: "Classic Bourbon",
          money: 1300,
          path: 'assets/1.png'),
      Product(
          name: "Monika",
          title: "Elegant Monika",
          money: 1400,
          path: 'assets/1.png'),
      Product(
          name: "Genshin Impact",
          title: "Genshin Special",
          money: 1600,
          path: 'assets/1.png'),
    ];

    List<Widget> coffeeRows = [];

    for (var i = 0; i < products.length; i += 2) {
      coffeeRows.add(
        Row(
          children: [
            Column(
              children: [
                _buildCoffeeItem(products[i]),
                if (i + 1 < products.length) _buildCoffeeItem(products[i + 1]),
              ],
            )
          ],
        ),
      );
    }

    return Container(
      width: 300,
      height: 400,
      padding: const EdgeInsets.only(top: 50),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: coffeeRows,
      ),
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
            margin: const EdgeInsets.only(left: 15, right: 15),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: Stack(
              children: [
                Image.asset(
                  product.path,
                ),
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
          const Padding(padding: EdgeInsets.only(top: 15)),
          SizedBox(
            width: 100,
            child: Text(
              product.name,
              style: const TextStyle(
                fontFamily: "EduAUVICWANTHand",
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
        ],
      ),
    );
  }
}
