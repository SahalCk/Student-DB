import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/student_model.dart';

ValueNotifier<List<Student>> students = ValueNotifier([]);

Future<void> addStudent(Student student) async {
  final studentDB = await Hive.openBox<Student>('student_db');
  students.value.add(student);
  await studentDB.add(student);
  students.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<Student>('student_db');
  students.value.clear();
  students.value.addAll(studentDB.values);
  students.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<Student>('student_db');
  await studentDB.deleteAt(index);
  getAllStudents();
}

Future<void> editStudent(int index, Student student) async {
  final studentDB = await Hive.openBox<Student>('student_db');
  await studentDB.putAt(index, student);
  getAllStudents();
  students.notifyListeners();
}
