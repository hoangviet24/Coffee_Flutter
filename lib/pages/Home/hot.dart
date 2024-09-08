// ignore_for_file: non_constant_identifier_names
import 'package:coffee/services/CartModel.dart';
import 'package:coffee/Data/Product.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Home/productDetail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Hotscene());
}

class Hotscene extends StatefulWidget {
  const Hotscene({super.key});

  @override
  State<Hotscene> createState() => _HotsceneState();
}

class _HotsceneState extends State<Hotscene> {
  bool _isSnackBarVisible = false;
  @override
  Widget build(BuildContext context) {
    // Danh sách các sản phẩm
    List<Product> products = [
      Product(
          id: 1,
          name: "Kamisato Ayaka 1",
          title: "Title 1",
          money: 1000,
          path: 'assets/1.png'),
      Product(
          id: 2,
          name: "Kamisato Ayaka 2",
          title: "Title 2",
          money: 2000,
          path: 'assets/2.png'),
      Product(
          id: 3,
          name: "Kamisato Ayaka 3",
          title: "Title 3",
          money: 3000,
          path: 'assets/3.png'),
      Product(
          id: 4,
          name: "Kamisato Ayaka 4",
          title: "Title 4",
          money: 4000,
          path: 'assets/4.png'),
      Product(
          id: 5,
          name: "Kamisato Ayaka 5",
          title: "Title 5",
          money: 5000,
          path: 'assets/5.png'),
      Product(
          id: 6,
          name: "Kamisato Ayaka 6",
          title: "Title 6",
          money: 6000,
          path: 'assets/6.png'),
      Product(
          id: 7,
          name: "Kamisato Ayaka 7",
          title: "Title 7",
          money: 7000,
          path: 'assets/7.png'),
      Product(
          id: 8,
          name: "Kamisato Ayaka 8",
          title: "Title 8",
          money: 8000,
          path: 'assets/8.png'),
      Product(
          id: 9,
          name: "Kamisato Ayaka 9",
          title: "Title 9",
          money: 9000,
          path: 'assets/9.png'),
    ];

    return Container(
      width: 300,
      height: 400,
      color: const Color.fromARGB(75, 75, 75, 1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
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
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 253, 253),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 10, 3, 3)
                            .withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
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
                              final cart = Provider.of<CartModel>(context,
                                  listen: false);
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
