import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DataBaseLearnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据库的使用"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("插入数据"), // 设置背景色为黄色
          color: Colors.green,
          // 设置斜角矩形边框
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => {dbDemo()},
        ),
      ),
    );
  }
}

int studentID = 123;

dbDemo() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'students_database.db'),
    onCreate: (db, version) => db.execute(
        "CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
    onUpgrade: (db, oldVersion, newVersion) {
      //dosth for migration
      print("old:$oldVersion,new:$newVersion");
    },
    version: 1,
  );

  Future<void> insertStudent(Student std) async {
    final Database db = await database;
    await db.insert(
      'students',
      std.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> students() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
  }

  var student1 = Student(id: '${++studentID}', name: '张三', score: 90);
  var student2 = Student(id: '${++studentID}', name: '李四', score: 80);
  var student3 = Student(id: '${++studentID}', name: '王五', score: 85);

  // Insert a dog into the database.
  await insertStudent(student1);
  await insertStudent(student2);
  await insertStudent(student3);

  students()
      .then((list) => list.forEach((s) => print('id:${s.id},name:${s.name}')));
  final Database db = await database;
  db.close();
}

class Student {
  String id;
  String name;
  int score;

  // 构造方法
  Student({
    this.id,
    this.name,
    this.score,
  });

  // 用于将 JSON 字典转换成类对象的工厂类方法
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }

  // 将类对象转换成 JSON 字典，方便插入数据库
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }
}
