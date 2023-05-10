import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databasename  ="ExemploDB.db";
  static final _databaseVersion = 1;
  static final table = "contato";
  static final columnId = 'id';
  static final columnNome = 'nome';
  static final columnIdade = 'idade';

    DatabaseHelper._privateConstructor();
    static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
    static Database? _database;

    Future<Database> get database async => 
      database ??= await _initDatabase();

      _initDatabase() async {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databasename);
        return await openDatabase(path,
          version: _databaseVersion,
          onCreate: _onCreate);
      }

      Future _onCreate(Database db, int version) async{
        await db.execute('''
              CREATE TABLE $table (
                $columnId INTEGER PRIMARY KEY,
                $columnNome TEXT NOT NULL,
                $columnIdade INTEGER NOT NULL,
              )
              ''');
      }



  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.query(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async{
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $Table'));
  }


  Future<int> update (Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}