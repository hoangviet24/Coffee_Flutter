import 'dart:io';
import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'pages/Home/hot.dart';
import 'pages/Home/other.dart';
import 'pages/Home/suggest.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _handelRefresh() async {}

  // ignore: non_constant_identifier_names
  void Exit() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: LiquidPullToRefresh(
              onRefresh: _handelRefresh,
              child: ListView(
                children: [
                  //Món ngon
                  Container(
                      margin: const EdgeInsets.all(25),
                      child: const Center(
                          child: Text(
                        "Món Hot",
                        style: TextStyle(
                            fontFamily: "EduAUVICWANTHand",
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ))),
                  const Hotscene(),
                  //Món đề cử
                  Container(
                      margin: const EdgeInsets.all(25),
                      child: const Center(
                          child: Text(
                        "Món đề cử",
                        style: TextStyle(
                            fontFamily: "EduAUVICWANTHand",
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ))),
                  const Suggest(),
                  //Món khác
                  Container(
                      margin: const EdgeInsets.all(25),
                      child: const Center(
                          child: Text(
                        "Các món khác",
                        style: TextStyle(
                            fontFamily: "EduAUVICWANTHand",
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ))),
                  const Other(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
