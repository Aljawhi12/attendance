import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class MyController extends GetxController {
  final subjects = <String>[].obs;
  final selectedSubject = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSubjects();
  }

  void loadSubjects() async {
    final db = await openDatabase('ali.db');
    final subjects = await db.rawQuery('SELECT colSubjectName FROM subjects ');
    List<String> names = [];

    for (final subject in subjects) {
      names.add(subject['colSubjectName'] as String);
    }

    names = names.toSet().toList();
    this.subjects.assignAll(names);
    selectedSubject.value = names.isNotEmpty ? names.first : '';
  }

  void selectSubject(String subject) {
    selectedSubject.value = subject;
  }
}
