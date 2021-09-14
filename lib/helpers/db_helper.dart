import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> infoDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'info.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_info(id TEXT PRIMARY KEY, name TEXT, emailId TEXT, gender INTEGER, imagePath TEXT)');
    }, version: 1);
  }

  static Future<sql.Database> mandiDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'mandi.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE mandi_db(cropId INTEGER, district TEXT, districtId INTEGER, hindiName TEXT, id INTEGER PRIMARY KEY, image TEXT, km REAL, lastDate TEXT, lat REAL, lng REAL, location TEXT, market TEXT, meters REAL, state TEXT, urlStr TEXT)');
    }, version: 1);
  }


  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.infoDatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.infoDatabase();
    return db.query(table);
  }

   static Future<void> insertIntoMandiDatabase(String table, Map<String, Object> data) async {
    final db = await DBHelper.mandiDatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getDataFromMandiDatabase(String table) async {
    final db = await DBHelper.mandiDatabase();
    return db.query(table);
  }
}
