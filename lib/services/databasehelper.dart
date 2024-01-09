import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const int _version=1;
  static const String _dbName="evanadb";

  static Future<Database> _getdb() async{
    return openDatabase(join(await getDatabasesPath(),_dbName),
      onCreate: (db,version) async => 
      await db.execute("CREATE TABLE Users (id INTEGER PRIMARY KEY, NAME TEXT NOT NULL, USERNAME TEXT NOT NULL,PASSWORD TEXT NOT NULL, EMAIL TEXT NOT NULL, PHONENUMBER NUMBER NOT NULL);"),
      version: _version
    );

  }
}