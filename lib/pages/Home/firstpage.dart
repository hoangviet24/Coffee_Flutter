// ignore_for_file: camel_case_types, avoid_types_as_parameter_names, non_constant_identifier_names, duplicate_ignore

import 'dart:io';
import 'package:coffee/pages/Manage/HistoryPage.dart';
import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:coffee/services/CartModel.dart';
import 'package:coffee/services/histories_cart.dart';
import 'package:coffee/services/page.dart';
import 'package:flutter/material.dart';
import 'package:coffee/pages/Help/help.dart';
import 'package:coffee/main.dart';
import 'package:coffee/pages/Manage/Cart.dart';
import 'package:coffee/pages/Manage/SettingPage.dart';
import 'package:coffee/pages/taskbar/Coffee.dart';
import 'package:coffee/pages/taskbar/Cake.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cartModel = CartModel();
  final historyDatabase = HistoryDatabase();
  await cartModel.initDb(); // Khởi tạo cơ sở dữ liệu
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(
          create: (context) {
            final cartModel = CartModel();
            cartModel.initDb(); // Khởi tạo cơ sở dữ liệu
            return cartModel;
          },
        ),
        ChangeNotifierProvider(create: (context) => historyDatabase),
      ],
      child: const firstpage(),
    ),
  );
}

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  // ignore: non_constant_identifier_names
  int _SelectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _SelectedIndex = index;
      switch (index) {
        case 0:
          _title = 'Trang chủ';
          break;
        case 1:
          _title = 'Đồ uống';
          break;
        case 2:
          _title = 'Bánh';
          break;
        case 3:
          _title = "User";
        default:
          _title = 'Tiêu đề mặc định';
      }
    });
  }

  final List _pages = [
    const MyApp(),
    const Coffee(),
    const Cake(),
    UserDataPage(),
  ];

  String _title = "Coffee";
  // ignore: non_constant_identifier_names
  void Exit() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, CartModel>(
      builder: (context, themeNotifier, CartModel, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme,
          debugShowCheckedModeBanner: false,
          title: 'Coffee',
          home: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                _title,
                style: const TextStyle(color: Colors.white),
              )),
              centerTitle: true,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ignore: prefer_const_constructors
                            builder: (context) => Help(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.help, color: Colors.white),
                    );
                  },
                ),
              ],
              backgroundColor: const Color.fromARGB(229, 142, 38, 1),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  const DrawerHeader(
                    child: Icon(
                      Icons.coffee,
                      size: 48,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return ListTile(
                        title: const Text(
                          "Cài đặt",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      return ListTile(
                        title: Text("Giỏ hàng (${CartModel.items.length})"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Cart(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      return ListTile(
                        title: const Text(
                          "Lịch sử",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryPage(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Builder(builder: (context) {
                    return ListTile(
                      title: const Text(
                        "Thoát",
                      ),
                      onTap: () {
                        Exit();
                      },
                    );
                  }),
                ],
              ),
            ),
            body: _pages[_SelectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _SelectedIndex,
              onTap: _navigateBottomBar,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_drink,
                    ),
                    label: "Đồ uống"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.cookie,
                    ),
                    label: "Bánh"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: "user"),
              ],
            ),
          ),
        );
      },
    );
  }
}
