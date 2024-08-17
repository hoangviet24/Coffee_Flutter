// ignore_for_file: file_names

import 'package:coffee/pages/taskbar/Coffee/taskCoffee.dart';
import 'package:coffee/pages/taskbar/Coffee/taskJuice.dart';
import 'package:coffee/pages/taskbar/Coffee/taskMilk.dart';
import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        child: const Coffee(),
      ),
    );

Future<void> _handleRefresh() async {}

class Coffee extends StatefulWidget {
  const Coffee({super.key});

  @override
  State<Coffee> createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  void _scrollToSection(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme,
          debugShowCheckedModeBanner: false,
          title: 'Coffee',
          home: Scaffold(
            body: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemCount: 4, // Số lượng phần tử trong danh sách
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => _scrollToSection(1),
                                icon: const Icon(Icons.coffee)),
                            const Text("Coffee")
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(right: 15)),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => _scrollToSection(2),
                                icon: const Icon(Icons.local_drink)),
                            const Text("Trà sữa")
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(right: 15)),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => _scrollToSection(3),
                                icon: const Icon(Icons.local_drink_outlined)),
                            const Text("Nước ép")
                          ],
                        )
                      ],
                    );
                  } else if (index == 1) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Cà phê",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'EduAUVICWANTHand',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(context)
                              .dividerColor, // Sử dụng màu từ chủ đề
                        ),
                        const SizedBox(height: 10),
                        const taskCoffee()
                      ],
                    );
                  } else if (index == 2) {
                    return Column(
                      children: [
                        const Text(
                          "Trà sữa",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'EduAUVICWANTHand',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(context)
                              .dividerColor, // Sử dụng màu từ chủ đề
                        ),
                        const SizedBox(height: 10),
                        const taskMilk(),
                      ],
                    );
                  } else if (index == 3) {
                    return Column(
                      children: [
                        const Text(
                          "Nước ép",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'EduAUVICWANTHand',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(context)
                              .dividerColor, // Sử dụng màu từ chủ đề
                        ),
                        const SizedBox(height: 10),
                        const taskJuice(),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink(); // Không có phần tử ở đây
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
