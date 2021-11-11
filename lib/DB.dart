import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Cities {
  final int id;
  final String name;

  Cities({
    this.id,
    this.name,
  });

  factory Cities.fromMap(Map<String, dynamic> json) => new Cities(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cities.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cities(
        id INTEGER PRIMARY KEY,
        name KEY
      )
    ''');
  }

  Future<List<Cities>> getCities() async {
    Database db = await instance.database;
    var cities = await db.query('cities', orderBy: 'name');
    List<Cities> citiesList =
        cities.isNotEmpty ? cities.map((e) => Cities.fromMap(e)).toList() : [];

    return citiesList;
  }

  Future<int> add(Cities city) async {
    Database db = await instance.database;
    return await db.insert('cities', city.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('cities', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Cities city) async {
    Database db = await instance.database;
    return await db.update('groceries', city.toMap(),
        where: "id = ?", whereArgs: [city.id]);
  }
}
