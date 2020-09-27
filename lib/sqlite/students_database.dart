import 'package:flutter_students/sqlite/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_students/models/students_model.dart';

class StudentsDB{

  DBHelper dbHelper;

  StudentsDB(){
    dbHelper = DBHelper.instance;
  }

  //insert new student
  Future<int> insert(Map<String, dynamic> student) async {
    Database db = await dbHelper.database;
    return await db.insert(DBHelper.tableStudents, student);
  }

  //update student
  Future<int> update(Map<String, dynamic> user) async {
    Database db = await dbHelper.database;
    int id = user[DBHelper.id];
    return await db.update(DBHelper.tableStudents, user, where: DBHelper.id +' = ?', whereArgs: [id]);
  }

  //get all students
  Future<List<StudentModel>> getAll() async {
    Database db = await dbHelper.database;
    var result = await db.query(DBHelper.tableStudents, orderBy: DBHelper.name + " ASC");
    List<StudentModel> list = List<StudentModel>();
    result.forEach((element) {
      StudentModel usersModel = StudentModel.fromMap(element);
      list.add(usersModel);
    });
    return list;
  }

  //delete student by id
  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete(DBHelper.tableStudents, where: DBHelper.id + ' = ?', whereArgs: [id]);
  }

  //delete all students
  Future<int> deleteAll() async {
    Database db = await dbHelper.database;
    return await db.delete(DBHelper.tableStudents);
  }

}