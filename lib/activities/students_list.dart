import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_students/activities/student_details.dart';
import 'package:flutter_students/models/students_model.dart';
import 'package:flutter_students/sqlite/students_database.dart';

class StudentsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StudentsState();
  }

}

class StudentsState extends State<StudentsList>{

  Future<List<StudentModel>> studentsList;
  int countStudents = 0;

  @override
  Widget build(BuildContext context){

    //get students list from database
    studentsList = StudentsDB().getAll();
    StudentsDB().getCount().then((value){
      debugPrint("value: $value");
      countStudents = value;
      debugPrint("count: $countStudents");
    });

    return myScaffold(countStudents);

  }

  Scaffold myScaffold(int count){
    debugPrint("start scaffold $count");
    return Scaffold(
      appBar: AppBar(
        title: Text("Students List"),
        actions: [
          Container(
            child: count == 0 ? Container() : IconButton(
              onPressed: (){
                alertDeleteAll(context);
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            ),
          )
        ],
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
                  alertDeleteStudent(context, student.id);
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

  justWait()async{
    String  text = await _await();
    debugPrint(text);
  }
  Future<String> _await(){
    Future<String> content = Future<String>.delayed(Duration(seconds: 10),(){
      return "endWait";
    });
    return content;
  }

  //refresh listView
  refreshStudentsList(){
    setState(() {});
  }

  //show alert before delete all students
  alertDeleteAll(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      title: Text("My Students App"),
      content: Text("delete all students?"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
          side: BorderSide(width: 1, color: Colors.redAccent)
      ),
      actions: <Widget>[
        Builder(
            builder: (context){
              return FlatButton(
                onPressed: (){
                  onBackPressed();
                },
                child: Text("CANCEL"),
              );
            }
        ),
        Builder(
            builder: (context){
              return FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  deleteAll();
                },
                child: Text("OK"),
              );
            }
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

  //show alert before delete all students
  alertDeleteStudent(BuildContext context, int id){
    AlertDialog alertDialog = AlertDialog(
      title: Text("My Students App"),
      content: Text("delete this student?"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
          side: BorderSide(width: 1, color: Colors.redAccent)
      ),
      actions: <Widget>[
        Builder(
            builder: (context){
              return FlatButton(
                onPressed: (){
                  onBackPressed();
                  refreshStudentsList();
                },
                child: Text("CANCEL"),
              );
            }
        ),
        Builder(
            builder: (context){
              return FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  delete(id);
                },
                child: Text("OK"),
              );
            }
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

  //delete all students
  deleteAll()async{
    final count = await StudentsDB().deleteAll();
    debugPrint("delete all: $count");
    if (count > 0)
      refreshStudentsList();
  }

  //delete student
  delete(int id)async{
    final count = await StudentsDB().delete(id);
    debugPrint("delete student: $count");
    if (count > 0)
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

  onBackPressed(){
    Navigator.pop(context);
  }

}