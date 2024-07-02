import 'package:path/path.dart';
import 'package:randomuser/models/user.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static int version = 1;
  static String databaseName = "randomuser.db";
  static String tableName = "favorites";
  static Database? _db;

  static Future<Database> openDb() async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query = '''
        CREATE TABLE $tableName (
          gender TEXT,
          title TEXT,
          firstName TEXT,
          lastName TEXT,
          email TEXT PRIMARY KEY,
          picture TEXT
        )
        ''';
        db.execute(query);
      },
    );
    return _db as Database;
  }
}

