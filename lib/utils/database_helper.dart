import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/benevole.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String benevoleTable = 'benevole_table';
  String colId = 'id';
  String colName = 'name';
  String colNumber = 'number';
  String colEmail = 'email';
  String colAdresse = 'adresse';
  String colProfession = 'profession';
  String colAvailability = 'availability';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'benevole.db';

    // Open/create the database at a given path
    var benevolesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return benevolesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $benevoleTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colNumber TEXT, $colEmail TEXT, $colAdresse TEXT, $colProfession TEXT, $colAvailability TEXT)');

    // await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
		// 		'$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  // Fetch Operation: Get all benevole objects from database
  Future<List<Map<String, dynamic>>> getBenevoleMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $benevoleTable order by $colEmail ASC');
    // var result = await db.query(benevoleTable, orderBy: '$colEmail ASC');
    var result = await db.query(benevoleTable, orderBy: '$colName');
    return result;
  }

  // Insert Operation: Insert a Benevole object to database
  Future<int> insertBenevole(Benevole benevole) async {
    Database db = await this.database;
    var result = await db.insert(benevoleTable, benevole.toMap());
    return result;
  }

  // Update Operation: Update a Benevole object and save it to database
  Future<int> updateBenevole(Benevole benevole) async {
    var db = await this.database;
    var result = await db.update(benevoleTable, benevole.toMap(),
        where: '$colId = ?', whereArgs: [benevole.id]);
    return result;
  }

  // Delete Operation: Delete a Benevole object from database
  Future<int> deleteBenevole(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $benevoleTable WHERE $colId = $id');
    return result;
  }

  // Get number of Benevole objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $benevoleTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Benevole List' [ List<Benevole> ]
  Future<List<Benevole>> getBenevoleList() async {
    var benevoleMapList =
        await getBenevoleMapList(); // Get 'Map List' from database
    int count =
        benevoleMapList.length; // Count the number of map entries in db table

    List<Benevole> benevoleList = List<Benevole>();
    // For loop to create a 'Benevole List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      benevoleList.add(Benevole.fromMapObject(benevoleMapList[i]));
    }

    return benevoleList;
  }
}
