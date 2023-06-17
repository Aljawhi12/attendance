

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/attendanceController.dart';
import 'controller/subjectController.dart';

class Attendance extends StatelessWidget {
  final controller = Get.put(AttendanceController());

  Attendance({Key? key, required String selectedSubject}) : super(key: key) {
    controller.loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'Selected Subject: ${Get.find<MyController>().selectedSubject.value}'),
          SizedBox(height: 16),
          Obx(() {
            if (controller.students.isEmpty) {
              return Text('No students to display');
            } else {
              final student =
                  controller.students.elementAt(controller.currentIndex);
              final isPresent = controller.attendance[student] ?? false;
              return Column(
                children: [
                  Text(
                    student,
                  ),
                ],
              );
            }
          }),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.markAttendance(false);
                  ();
                },
                child: Text('Absent'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.markAttendance(true);
                  controller.update();
                  ;
                  // showAttendanceSavedDialog(context);
                },
                child: Text('Present'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
