import 'package:crud_app_flutter/data_model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
//open the database
late Database _db;
Future<void> initializeDataBase() async {
  _db = await openDatabase('students.db', version: 1,
      onCreate: (Database db, int version) async {
    // Students Table creation
    await db.execute(
        'CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT,age TEXT,rollno TEXT)');
  });
}

//insert the student data to  database
Future<int> addStudent(StudentModel value) async {
  studentListNotifier.value.add(value);
  int k = await _db.rawInsert(
      'INSERT INTO students(id,name, age,rollno) VALUES(?,?, ?,?)',
      [value.id, value.name, value.age, value.rollno]);

  getAllStudentsDetails();
  studentListNotifier.notifyListeners();
  return k;
}

//get the all students data from database
Future<void> getAllStudentsDetails() async {
  studentListNotifier.value.clear();
  final _values =
      await _db.rawQuery('SELECT * FROM students ORDER BY id DESC ');
  print(_values);
  studentListNotifier.value.clear();
  //Get each map on by one
  for (var map in _values) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  }
}

//update student
Future<void> updateStudent(
    int id, String name, String age, String rollno) async {
  await _db.rawUpdate(
      'UPDATE students SET name=? , age =? ,rollno =? WHERE id=?',
      [name, age, rollno, id]);
  getAllStudentsDetails();
}

//delete the data from database
Future<void> deleteStudent(int id) async {
  final db = _db;
  await db.delete(
    'students',
    where: 'id = ?',
    whereArgs: [id],
  );
  studentListNotifier.value.clear();
  studentListNotifier.notifyListeners();
  getAllStudentsDetails();
}
