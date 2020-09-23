import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Student();
  }

}

class Student extends State<StudentDetails>{

  static var status = ["success", "failed"];

  String studentStatus = "success";

  String name = "";
  String description = "";

  TextEditingController studentName = TextEditingController();
  TextEditingController studentDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                onChanged: (String selectedItem){
                  setState(() {
                    studentStatus = selectedItem;
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
                onChanged: (name){
                  this.name = name;
                },
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
                  debugPrint("try to save student");
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

}