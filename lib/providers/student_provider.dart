import 'package:flutter/material.dart';
import 'package:student_management_provider/db/db_helper.dart';
import 'package:student_management_provider/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;

  Future<void> fetchStudents() async {
    _students = await DBHelper().getAllStudents();
    notifyListeners();
  }

  Future<void> addStudent(StudentModel student) async {
    await DBHelper().insertStudent(student);
    _students.add(student);
    notifyListeners();
  }

  Future<void> updateStudent(StudentModel student) async {
    await DBHelper().updateStudent(student);
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      _students[index] = student;
      notifyListeners();
    }
  }

  Future<void> deleteStudent(int id) async {
    await DBHelper().deleteStudent(id);
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  List<StudentModel> searchStudents(String query) {
    if (query.isEmpty) {
      return _students;
    } else {
      return _students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  StudentModel? getStudentById(int id) {
    try {
      return _students.firstWhere((student) => student.id == id);
    } catch (e) {
      return null;
    }
  }

  bool _isGrid = false;
  String _searchQuery = '';

  bool get isGrid => _isGrid;
  String get searchQuery => _searchQuery;

  void toggleViewMode() {
    _isGrid = !_isGrid;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<StudentModel> get filteredStudents =>
      _searchQuery.isEmpty
          ? _students
          : _students
              .where(
                (student) => student.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .toList();
}
