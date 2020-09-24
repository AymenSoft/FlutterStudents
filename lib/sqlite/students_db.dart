import 'package:flutter_students/sqlite/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_students/models/students.dart';

class StudentsDB{

  DBHelper dbHelper = DBHelper();
  Database db;

  StudentsDB(){
    if (db == null){
      initiateDatabase();
    }
  }

  void initiateDatabase()async{
    db = await dbHelper.get();
  }

  insert(Student student)async{
    return await db.insert(DBHelper.TABLE_STUDENTS, student.toMap());
  }

  update(Student student)async{
    return await db.update(DBHelper.TABLE_STUDENTS, student.toMap(), where: DBHelper.id+" ?", whereArgs: [student.getId]);
  }

  getById(int id)async{
    var result = await db.query(DBHelper.TABLE_STUDENTS, where: DBHelper.id+" ?", whereArgs: [id]);
    Student student = result.isNotEmpty ? Student.getMap(result.first) : Null;
    return student;
  }

  getAll()async{
    var result = await db.query(DBHelper.TABLE_STUDENTS, orderBy: DBHelper.id+"ASC");
    List<Student> list = result.isNotEmpty ? result.map((c) => Student.getMap(c)).toList() : [];
    return list;
  }

  deleteById(int id)async{
    return await db.delete(DBHelper.TABLE_STUDENTS, where: DBHelper.id+" ?", whereArgs: [id]);
  }

  clear()async{
    return await db.delete(DBHelper.TABLE_STUDENTS);
  }


}