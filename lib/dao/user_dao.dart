import 'package:sqflite/sqflite.dart';
import 'package:randomuser/database/app_database.dart';
import 'package:randomuser/models/user.dart';

class UserDao {
  insert(User user) async {
    Database db = await AppDatabase.openDb();
    await db.insert(AppDatabase.tableName, user.toMap());
  }

  delete(User user) async {
    Database db = await AppDatabase.openDb();
    await db.delete(AppDatabase.tableName,
        where: "email = ?", whereArgs: [user.email]);
  }

  Future<bool> isFavorite(User user) async {
    Database db = await AppDatabase.openDb();
    List maps = await db.query(AppDatabase.tableName,
        where: "email = ?", whereArgs: [user.email]);
    return maps.isNotEmpty;
  }

  Future<List<User>> fetchFavorites() async {
    Database db = await AppDatabase.openDb();
    List maps = await db.query(AppDatabase.tableName);
    return maps.map((map) => User.fromMap(map)).toList();
  }
}
