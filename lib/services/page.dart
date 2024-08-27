import 'package:coffee/pages/Account/Login.dart';
import 'package:coffee/pages/theme/themenotifi.dart';
import 'package:coffee/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:coffee/Data/User.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Users model

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        child: UserDataPage(),
      ),
    );

class UserDataPage extends StatefulWidget {
  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  late Future<Users?> _currentUserFuture;

  @override
  void initState() {
    super.initState();
    _currentUserFuture =
        DatabaseHelper().getCurrentUser(); // Lấy dữ liệu người dùng
  }

  Future<void> _logout() async {
    // Xóa thông tin người dùng khỏi SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedUsername');

    // Cập nhật lại Future để hiển thị trạng thái đăng xuất
    setState(() {
      _currentUserFuture = DatabaseHelper().getCurrentUser();
    });

    // Chuyển hướng người dùng về trang đăng nhập hoặc trang chính
    Navigator.pushReplacementNamed(
        context, '/login'); // Hoặc trang khác phù hợp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Users?>(
        future: _currentUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: LoginScreen());
          }
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      'ID: ${user.usrId}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Tên người dùng: ${user.usrName}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mật khẩu: ${user.usrPassword}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Tạo khoảng cách
                Center(
                  child: ElevatedButton(
                    onPressed: _logout, // Gọi hàm logout
                    child: const Text('Đăng xuất'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Xây dựng tiêu đề AppBar dựa trên trạng thái đăng nhập

  // Xây dựng các hành động AppBar dựa trên trạng thái đăng nhập
  List<Widget> _buildAppBarActions() {
    return [
      FutureBuilder<Users?>(
        future: _currentUserFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox
                .shrink(); // Không hiển thị nút đăng xuất nếu chưa đăng nhập
          }
          return IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          );
        },
      ),
    ];
  }
}
