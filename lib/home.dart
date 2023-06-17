import 'package:attendece/sqliteDb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'attendance.dart';
import 'controller/subjectController.dart';

// ignore: must_be_immutable
class Myhome extends StatelessWidget {
  final MyController _myController = Get.put(MyController());
  Sqldb sqlDb = Sqldb();

  Myhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => DropdownButton<String>(
                  value: _myController.selectedSubject.value,
                  items: _myController.subjects.map((String name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _myController.selectSubject(value!);
                  },
                )),
            // MaterialButton(
            //   onPressed: () async {
            //     await sqlDb.mydeleteDatabase();
            //   },
            //   child: Text("delete database"),
            // ),
            // MaterialButton(
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   onPressed: () async {
            //     int response = await sqlDb.insertData(
            //         "INSERT INTO STUDENT (name, dep_name, coll_name, level) VALUES ('ahmde ali', 'it', 'mtin', 4),('ali omer', 'it', 'mtin', 4),('salem omer', 'it', 'mtin', 4),('ahmed omer', 'it', 'mtin', 4),('zaid mouhmed', 'it', 'mtin', 4)");
            //     print(response);
            //     print("data is inserted ==============");
            //   },
            //   child: const Text("inset a name"),
            // ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
                List<Map> response =
                    await sqlDb.readData("SELECT * FROM 'STUDENT'");
                print(response);
                print("data is student ==============");
              },
              child: const Text("SELECT  a name"),
            ),
            // MaterialButton(
            //   color: Colors.red,
            //   textColor: Colors.white,
            //   onPressed: () async {
            //     int response = await sqlDb.insertData(
            //         "INSERT INTO subjects (colSubjectName, dep_name, coll_name, sub_level) VALUES ('java', 'it', 'mtin', 4),('django', 'it', 'mtin', 4),('mvc', 'it', 'mtin', 4),('flutter', 'it', 'mtin', 4),('c++', 'it', 'mtin', 4)");
            //     print(response);
            //     print("data is inserted ==============");
            //   },
            //   child: const Text("inset a name"),
            // ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                List<Map> response =
                    await sqlDb.readData("SELECT * FROM 'subjects'");
                print(response);
                print("data is SELECTED ==============");
              },
              child: const Text("SELECT  a name"),
            ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                List<Map> response =
                    await sqlDb.readData("SELECT * FROM 'attendance'");
                print(response);
                print("data is SELECTED ==============");
              },
              child: const Text("SELECT  a name"),
            ),
            Obx(() => Text('${_myController.selectedSubject.value}')),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Attendance(
                            selectedSubject:
                                _myController.selectedSubject.value,
                          )),
                );
              },
              child: const Text("attendance"),
            ),
          ],
        ),
      ),
    );
  }
}
