import 'package:flutter/material.dart';
import 'package:flutter_students/activities/students_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Students",
      home: Scaffold(
        body: Container(
          child: StudentsList(),
        ),
      ),
    );
  }

}

