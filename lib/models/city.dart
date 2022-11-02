// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableCity = 'city';
final String columnId = '_id';
final String columnName = 'name';
final String columnLat = 'lat';
final String columnLon = 'lon';
final String filePath = 'cities.db';

class City {
  int? id;
  double? lat;
  double? lon;
  String? name;
  City({this.id, this.name, this.lat, this.lon});

  City.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnLat: lat,
      columnLon: lon,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  City.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    lat = map[columnLat];
    lon = map[columnLon];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['name'] = name;
    return data;
  }
}

class CityProvider {
  Database? db;

  Future open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), filePath),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        create table $tableCity ( 
          $columnId integer primary key autoincrement, 
          $columnName text,
          $columnLat real,
          $columnLon real)
        ''');
      },
    );
  }

  Future<void> insert(City city) async {
    final database = db;
    await database!.insert(tableCity, city.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<City> getCity(int id) async {
    final database = db;
    List<Map<String, dynamic>> maps = await database!.query(tableCity,
        columns: [columnId, columnName, columnLat, columnLon],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return City.fromMap(maps.first);
    }
    return City();
  }

  Future<int> delete(int id) async {
    final database = db;
    return await database!
        .delete(tableCity, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> update(City city) async {
    final database = db;
    await database!.update(tableCity, city.toMap(),
        where: '$columnId = ?', whereArgs: [city.id]);
  }

  Future<List<City>> getAllCity() async {
    final database = db;
    final List<Map<String, dynamic>> maps = await database!.query(tableCity);
    final list = maps.map((e) => City.fromMap(e)).toList();
    return list;
  }

  Future close() async => db!.close();
}

// Read result đọc kqkq
// List<Map<String, Object?>> records = await db.query('my_table');

// get the first record
// Map<String, Object?> mapRead = records.first;
// // Update it in memory...this will throw an exception
// mapRead['my_column'] = 1;
// // Crash... `mapRead` is read-only

//////// Update record
// // get the first record
// Map<String, Object?> map = Map<String, Object?>.from(mapRead);
// // Update it in memory now
// map['my_column'] = 1;