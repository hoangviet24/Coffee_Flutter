import 'package:coffee/pages/taskbar/Cake/taskCake.dart';
import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        child: Cake(),
      ),
    );

class Cake extends StatefulWidget {
  const Cake({super.key});

  @override
  State<Cake> createState() => _CakeState();
}

class _CakeState extends State<Cake> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme,
          debugShowCheckedModeBanner: false,
          title: 'Coffee',
          home: const Scaffold(
            body: Center(child: taskCake()),
          ),
        );
      },
    );
  }
}
