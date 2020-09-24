import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_students/models/students.dart';

class DBHelper{

  static DBHelper dbHelper;
  static Database database;

  DBHelper.createInstance();

  factory DBHelper(){
    if(dbHelper == null){
      dbHelper = DBHelper.createInstance();
    }
    return dbHelper;
  }

  Future<Database> get () async{
    if (database == null){
      database = await initialiseDataBase();
    }
    return database;
  }

  final int DB_Version = 1;
  final String DB_Name = "students.db";

  final String TABLE_STUDENTS = "TABLE_STUDENTS";
  String id = "id";
  String name = "name";
  String description = "description";
  String status = "status";

  //create table devices
  final String Create_TABLE_DEVICES = "Create Table IF NOT EXISTS TABLE_STUDENTS"
      "("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name STRING,"
      "description STRING"
      "status STRING"
      ")";

  Future<Database> initialiseDataBase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + DB_Name;
    return await openDatabase(path, version: DB_Version, onCreate: createDataBase);
  }

  void createDataBase(Database db, int version)async{
    await db.execute(Create_TABLE_DEVICES);
  }

}