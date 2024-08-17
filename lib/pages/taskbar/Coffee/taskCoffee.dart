import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MaterialApp(
        home: Scaffold(
          body: taskCoffee(),
        ),
      ),
    ),
  );
}

class taskCoffee extends StatefulWidget {
  const taskCoffee({super.key});

  @override
  State<taskCoffee> createState() => _taskCoffeeState();
}

class _taskCoffeeState extends State<taskCoffee> {
  List<Product> products = [
    Product(
        name: "Americano",
        title: "Rich Americano",
        money: 1000,
        path: 'assets/Americano.png'),
    Product(
        name: "Robusta",
        title: "Bold Robusta",
        money: 1200,
        path: 'assets/Americano.png'),
    Product(
        name: "Kopi Luwak",
        title: "Exotic Kopi Luwak",
        money: 2000,
        path: 'assets/Americano.png'),
    Product(
        name: "Arabica",
        title: "Smooth Arabica",
        money: 1500,
        path: 'assets/Americano.png'),
    Product(
        name: "Cherry",
        title: "Sweet Cherry",
        money: 1100,
        path: 'assets/Americano.png'),
    Product(
        name: "Bourbon",
        title: "Classic Bourbon",
        money: 1300,
        path: 'assets/Americano.png'),
    Product(
        name: "Moka",
        title: "Classic Moka",
        money: 1400,
        path: 'assets/Americano.png'),
    Product(
        name: "Typical",
        title: "Typical Blend",
        money: 1600,
        path: 'assets/Americano.png'),
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
                    child: Consumer<CartModel>(
                      builder: (context, cartModel, child) {
                        return GestureDetector(
                          onTap: () {
                            cartModel
                                .add(product); // Thêm sản phẩm vào giỏ hàng
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Sản phẩm đã được thêm vào giỏ hàng'),
                                duration: Duration(milliseconds: 200),
                              ),
                            );
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
                        );
                      },
                    )),
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
