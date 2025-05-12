import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../repository/student_repository.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();

  List<Student> _students = [];
  List<Student> get students => _students;

  List<Student> _searchResults = [];
  List<Student> get searchResults => _searchResults;

  bool _isGridView = false;
  bool get isGridView => _isGridView;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _lastQuery = '';

  StudentProvider() {
    loadStudents();
  }

  Future<void> loadStudents() async {
    _students = await _repository.fetchStudents();

    if (_isSearching && _lastQuery.isNotEmpty) {
      _searchResults =
          _students.where((student) {
            return student.name.toLowerCase().startsWith(
              _lastQuery.toLowerCase(),
            );
          }).toList();
    }

    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    await _repository.addStudent(student);
    await loadStudents();
  }

  Future<void> updateStudent(Student student) async {
    await _repository.updateStudent(student);
    await loadStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _repository.deleteStudent(id);
    await loadStudents();
  }

  void searchStudent(String query) {
    _lastQuery = query;

    if (query.isEmpty) {
      _searchResults.clear();
      _isSearching = false;
    } else {
      _searchResults =
          _students.where((student) {
            return student.name.toLowerCase().startsWith(query.toLowerCase());
          }).toList();
      _isSearching = true;
    }

    notifyListeners();
  }

  void clearSearch() {
    _searchResults.clear();
    _lastQuery = '';
    _isSearching = false;
    notifyListeners();
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void toggleSearch(bool isSearching) {
    _isSearching = isSearching;
    notifyListeners();
  }
}
