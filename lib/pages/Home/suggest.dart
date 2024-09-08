import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:provider/provider.dart';

void main() => const Suggest();

class Suggest extends StatefulWidget {
  const Suggest({super.key});

  @override
  State<Suggest> createState() => _SuggestState();
}

class _SuggestState extends State<Suggest> {
  bool _isSnackBarVisible = false;
  @override
  Widget build(BuildContext context) {
    // Danh sách các sản phẩm
    List<Product> products = [
      Product(
          id: 18,
          name: "Americano",
          title: "Rich Americano",
          money: 1000,
          path: 'assets/Americano.png'),
      Product(
          id: 19,
          name: "Robusta",
          title: "Bold Robusta",
          money: 1200,
          path: 'assets/Americano.png'),
      Product(
          id: 20,
          name: "Kopi Luwak",
          title: "Exotic Kopi Luwak",
          money: 2000,
          path: 'assets/Americano.png'),
      Product(
          id: 21,
          name: "Arabica",
          title: "Smooth Arabica",
          money: 1500,
          path: 'assets/Americano.png'),
      Product(
          id: 22,
          name: "Cherry",
          title: "Sweet Cherry",
          money: 1100,
          path: 'assets/Americano.png'),
      Product(
          id: 23,
          name: "Bourbon",
          title: "Classic Bourbon",
          money: 1300,
          path: 'assets/Americano.png'),
      Product(
          id: 24,
          name: "Moka",
          title: "Classic Moka",
          money: 1400,
          path: 'assets/Americano.png'),
      Product(
          id: 25,
          name: "Typical",
          title: "Typical Blend",
          money: 1600,
          path: 'assets/Americano.png'),
    ];

    return Expanded(
      child: Column(
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
              id: product.id,
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
