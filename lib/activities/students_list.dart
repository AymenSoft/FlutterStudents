import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_students/activities/student_details.dart';
import 'package:flutter_students/models/students_model.dart';
import 'package:flutter_students/sqlite/students_database.dart';

class StudentsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Students();
  }

}

class Students extends State<StudentsList>{

  Future<List<StudentModel>> studentsList;

  @override
  Widget build(BuildContext context) {

    //get students list from database
    studentsList = StudentsDB().getAll();

    return Scaffold(
      appBar: AppBar(
        title: Text("Students List"),
      ),
      body: getStudentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          studentDetails("Add Student", "add");
          refreshStudentsList();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  FutureBuilder getStudentsList(){
    return FutureBuilder<List<StudentModel>>(
      future: studentsList,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, position){
              StudentModel student = snapshot.data[position];
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.redAccent),
                onDismissed: (direction){
                  debugPrint("dismiss");
                },
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    onTap: (){
                      debugPrint("item click");
                      studentDetails(student.name, "update", student);
                    },
                    leading: Icon(Icons.person, color: Colors.blueAccent, size: 35),
                    title: Text(student.name),
                    subtitle: Text(student.description),
                    trailing: Container(
                      child: (student.status == "success") ?
                      Icon(Icons.offline_pin, color: Colors.blueAccent,) :
                      Icon(Icons.announcement, color: Colors.redAccent,),
                    ),
                  ),
                )
              );
            }
          );
        }else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  //refresh listView
  refreshStudentsList(){
    setState(() {});
  }

  //insert new student
  insert()async{
    StudentModel student = StudentModel();
    student.name = "Aymen";
    student.description = "Mobile Developer";
    student.status = "success";
    final id = await StudentsDB().insert(student.toMap());
    debugPrint("student $id added");
    refreshStudentsList();
  }

  void studentDetails(screenTitle, action, [student])async{
    bool refresh = await Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return StudentDetails(screenTitle, action, student);
    }
    ));

    if (refresh)
      refreshStudentsList();

  }

}