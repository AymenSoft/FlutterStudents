
import 'package:flutter_students/sqlite/database_helper.dart';

class StudentModel {
  int id;
  String name;
  String description;
  String status;

  StudentModel({this.id, this.name, this.description, this.status});

  factory StudentModel.fromMap(Map<String, dynamic> map){
    StudentModel userModel = StudentModel(
        id : map[DBHelper.id],
        name : map[DBHelper.name],
        description: map[DBHelper.description],
      status: map[DBHelper.status]
    );
    return userModel;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map[DBHelper.id] = id;
    map[DBHelper.name] = name;
    map[DBHelper.description] = description;
    map[DBHelper.status] = status;
    return map;
  }

}