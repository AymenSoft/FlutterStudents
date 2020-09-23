import 'package:flutter/material.dart';
import 'package:flutter_students/activities/student_details.dart';

class StudentsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Students();
  }

}

class Students extends State<StudentsList>{

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students List"),
      ),
      body: getStudentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          studentDetails("Add Student");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getStudentsList(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white10,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person),
            ),
            title: Text("Student Name"),
            subtitle: Text("Student description"),
            trailing: Icon(
              Icons.delete,
              color: Colors.blueAccent,
            ),
            onTap: (){
              studentDetails("Update Student");
            },
          ),
        );
      }
    );
  }

  void studentDetails(screenTitle){
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return StudentDetails(screenTitle);
    }
    ));
  }

}