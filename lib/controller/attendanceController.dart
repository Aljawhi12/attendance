import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'subjectController.dart';

class AttendanceController extends GetxController {
  final students = <String>[].obs;
  final attendance = <String, bool>{}.obs;
  int currentIndex = 0;
  bool isMarked = false;
  final Map<String, int> studentNamesToIds = {};

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  void loadStudents() async {
    final db = await openDatabase('ali.db');

    final myController = Get.find<MyController>();
    final selectedSubject = myController.selectedSubject.value;

    final students = await db.rawQuery(
        "SELECT id,name FROM STUDENT JOIN subjects ON STUDENT.dep_name = subjects.dep_name AND STUDENT.coll_name = subjects.coll_name AND STUDENT.level = subjects.sub_level WHERE subjects.colSubjectName = '$selectedSubject'");
    for (final student in students) {
      final studentName = student['name'] as String?;
      final studentId = student['id'] as int?;
      if (studentName != null && studentId != null) {
        studentNamesToIds[studentName] = studentId;
      }
    }

    final studentNames = studentNamesToIds.keys.toList();
    this.students.assignAll(studentNames);
    attendance.clear();
    for (final studentName in studentNames) {
      attendance[studentName] = false;
    }
    for (final entry in studentNamesToIds.entries) {
      print('this the map i want to check${entry.key}: ${entry.value}');
    }
  }

  void markAttendance(bool isPresent) {
    attendance[students[currentIndex]] = isPresent;
    isMarked = true;

    saveAttendance();
    nextStudent();
    for (final entry in studentNamesToIds.entries) {
      print('${entry.key}: ${entry.value}');
    }
  }

  

  void nextStudent() {
    if (isMarked) {
      attendance.remove(students[currentIndex]);
      isMarked = false;
    }
    currentIndex++;
    if (currentIndex >= students.length) {
      currentIndex = 0;

      Get.snackbar(
        'Attendance Saved',
        'Attendance has been successfully saved for all students.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void saveAttendance() async {
    final db = await openDatabase('ali.db');
    final myController = Get.find<MyController>();
    final selectedSubject = myController.selectedSubject.value;
    final subject = await db.rawQuery(
        "SELECT sub_id FROM subjects WHERE colSubjectName = '$selectedSubject'");

    for (final studentName in attendance.keys) {
      final studentId = studentNamesToIds[studentName];
      final isPresent = attendance[studentName] ?? false;;
      final subId = subject[0]['sub_id'] as int?;

      await db.rawInsert(
        'INSERT INTO attendance (std_id, sub_id, is_present) VALUES (?, ?, ?)',
        [studentId, subId, isPresent ? 1 : 0],
      );
      print('attendance is insert');
    }
    attendance.clear();
  }
}
