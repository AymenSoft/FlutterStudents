import 'package:flutter/material.dart';
import 'package:flutter_students/models/students_model.dart';
import 'package:flutter_students/sqlite/students_database.dart';

class StudentDetails extends StatefulWidget{

  String screenTitle = "Student Details";

  String action;

  StudentModel student;

  StudentDetails(this.screenTitle, this.action, [this.student]);

  @override
  State<StatefulWidget> createState() {
    return Student(screenTitle, action, student);
  }

}

class Student extends State<StudentDetails>{

  static var status = ["success", "failed"];

  String name = "";
  String description = "";
  String studentStatus = "success";

  TextEditingController studentName = TextEditingController();
  TextEditingController studentDescription = TextEditingController();

  String screenTitle = "Student Details";

  String action;

  StudentModel student;

  bool activityResult = false;

  Student(this.screenTitle, this.action, [this.student]);

  @override
  Widget build(BuildContext context) {

    debugPrint(action);
    if (action == "update"){
      debugPrint("user: ${student.name}, ${student.description}");
      studentName.text = student.name;
      studentDescription.text = student.description;
      setDropdown(student.status);
      debugPrint(studentName.text);
    }

    return WillPopScope(
      onWillPop: (){
        onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              onBackPressed();
            },
          ),
          actions: [
            Container(
              child: action != "update" ? Container() : IconButton(
                onPressed: (){
                  alertDelete(context);
                },
                icon: Icon(Icons.delete),
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                  onChanged: (String selectedItem){
                    setState(() {
                      setDropdown(selectedItem);
                    });
                  },
                  items: status.map((String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  value: studentStatus,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: studentName,
                  decoration: textFieldDecoration("add name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: studentDescription,
                  decoration: textFieldDecoration("add description"),
                  onChanged: (description){
                    this.description = description;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: (){
                    saveStudent();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 1, color: Colors.redAccent)
                  ),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        color: Colors.redAccent
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  InputDecoration textFieldDecoration(String hintText){
    return InputDecoration(
      filled: true,
      fillColor: Color(0xFFF2F2F2),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.orange),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.green),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.black)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.yellowAccent)),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
    );
  }

  //set drop down success value
  setDropdown(String value){
    studentStatus = value;
    student.status = studentStatus;
  }

  //save student
  saveStudent(){
    if (action == 'add'){
      insert();
    }else {
      update();
    }
  }

  //insert new student
  insert()async{
    debugPrint(studentName.text);
    student = StudentModel();
    student.name = studentName.text;
    student.description = studentDescription.text;
    student.status = studentStatus;
    final id = await StudentsDB().insert(student.toMap());
    if (id > 0){
      activityResult = true;
      onBackPressed();
    }
  }

  //update current student
  update()async{
    debugPrint(studentName.text);
    student.name = studentName.text;
    student.description = studentDescription.text;
    student.status = studentStatus;
    final id = await StudentsDB().update(student.toMap());
    if (id > 0){
      activityResult = true;
      onBackPressed();
    }
  }

  //delete student
  delete()async{
    final count = await StudentsDB().delete(student.id);
    debugPrint("delete: $count");
    if (count > 0){
      debugPrint("count");
      activityResult = true;
      Navigator.pop(context, activityResult);
      Navigator.pop(context, activityResult);
    }
  }

  alertDelete(BuildContext context){
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
                },
                child: Text("CANCEL"),
              );
            }
        ),
        Builder(
            builder: (context){
              return FlatButton(
                onPressed: (){
                  delete();
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

  void onBackPressed(){
    Navigator.pop(context, activityResult);
  }

}