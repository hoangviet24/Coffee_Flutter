import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee/Data/User.dart';

class DatabaseHelper {
  final String databaseName = "notes.db";

  String usersTable =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(usersTable);
    });
  }

  Future<String?> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedUsername');
  }

  Future<Users?> getCurrentUser() async {
    final Database db = await initDB();
    final savedUsername = await getSavedUsername();
    if (savedUsername == null) {
      return null;
    }
    final result = await db
        .query('users', where: 'usrName = ?', whereArgs: [savedUsername]);
    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    }
    return null;
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();
    final result = await db.query(
      'users',
      where: 'usrName = ? AND usrPassword = ?',
      whereArgs: [user.usrName, user.usrPassword],
    );

    if (result.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUsername', user.usrName);
      return true;
    } else {
      return false;
    }
  }

  Future<int> signup(Users user) async {
    final Database db = await initDB();
    int result = await db.insert('users', user.toMap());

    if (result > 0) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUsername', user.usrName);
    }
    return result;
  }
}
