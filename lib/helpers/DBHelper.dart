import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  //Database infomation
  final int dbVersion = 1;
  static Database _database;

  String dbName;
  String createQuery;

  DBHelper({this.dbName, this.createQuery});

  Future<Database> get db async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "$dbName");
    Database db =
        await openDatabase(path, version: dbVersion, onCreate: (db, version) {
      return db.execute("$createQuery");
    });
    return db;
  }
}
