import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Đảm bảo màu nút quay về là trắng
        ),
        title: const Text(
          'Settings Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(229, 142, 38, 1),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeNotifier.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme(); // Cập nhật chủ đề toàn bộ ứng dụng
              },
            ),
          ),
          ListTile(
            title: const Text('Terms and Conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: const Center(child: Text('Terms and Conditions Content')),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: const Center(child: Text('About Us Content')),
    );
  }
}
