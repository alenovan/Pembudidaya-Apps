// //https://www.codepolitan.com/mengakses-database-sqlite-dengan-flutter
import 'dart:convert';

import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
//pubspec.yml

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();
//singleton class
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'lele.db';
    print(directory.path);
    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    print("baru");
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tb_penentuan_panen (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pond_id INTEGER, 
        sow_date INTEGER, 
        seed_amount INTEGER,
        seed_weight INTEGER,
        seed_price INTEGER, 
        survival_rate INTEGER, 
        feed_conversion_ratio INTEGER, 
        feed_id INTEGER, 
        target_fish_count INTEGER, 
        target_price INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future select(int id) async {
    Database db = await this.database;
    var mapList = await db.rawQuery('SELECT * FROM tb_penentuan_panen where pond_id = $id');
    var decode = json.decode(json.encode(mapList))[0];
    // var data = SqliteDataPenentuanPanen(
    //     decode["pond_id"],
    //     decode["sow_date"],
    //     decode["seed_amount"],
    //     decode["seed_weight"],
    //     decode["seed_price"],
    //     decode["survival_rate"],
    //     decode["feed_conversion_ratio"],
    //     decode["feed_id"],
    //     decode["target_fish_count"],
    //     decode["target_price"],
    //     decode["status"]
    // );
    return decode;
  }

  Future select_count(int id) async {
    Database db = await this.database;
    var mapList = await db.rawQuery('SELECT COUNT(*) as jumlah FROM tb_penentuan_panen where pond_id = $id');
    var encode = json.encode(mapList);
    return json.decode(encode)[0]["jumlah"];
  }

//create databases
  Future<int> insert(SqliteDataPenentuanPanen object) async {
    Database db = await this.database;
    int count = await db.insert('tb_penentuan_panen', object.toMap());
    return count;
  }
//update databases
  Future<int> update(SqliteDataPenentuanPanen object) async {
    Database db = await this.database;
    int count = await db.update('tb_penentuan_panen', object.toMap(),
        where: 'pond_id=?',
        whereArgs: [object.pond_id]);
    print("update");
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('tb_penentuan_panen',
        where: 'id=?',
        whereArgs: [id]);
    return count;
  }


}