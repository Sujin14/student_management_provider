import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/screens/student_detail_screen.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';
import '../utils/dialogs.dart';
import '../widgets/student_list_view.dart';
import '../widgets/student_grid_view.dart';
import '../widgets/student_form.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students =
        studentProvider.isSearching
            ? studentProvider.searchResults
            : studentProvider.students;

    return Scaffold(
      appBar: AppBar(
        title:
            studentProvider.isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search by name',
                    border: InputBorder.none,
                  ),
                  onChanged: (query) {
                    studentProvider.searchStudent(query);
                  },
                )
                : const Text('Student Records'),
        actions: [
          IconButton(
            icon: Icon(
              studentProvider.isGridView ? Icons.list : Icons.grid_view,
            ),
            onPressed: () => studentProvider.toggleViewMode(),
          ),
          IconButton(
            icon: Icon(
              studentProvider.isSearching ? Icons.close : Icons.search,
            ),
            onPressed: () {
              if (studentProvider.isSearching) {
                _searchController.clear();
                studentProvider.clearSearch();
              } else {
                studentProvider.toggleSearch(true);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepOrange, Colors.amber]),
        ),
        child:
            studentProvider.isGridView
                ? StudentGridView(
                  students: students,
                  onTap: (student) => _viewStudentDetails(context, student),
                  onEdit: (student) => _editStudent(context, student),
                  onDelete: (student) => _deleteStudent(context, student),
                )
                : StudentListView(
                  students: students,
                  onTap: (student) => _viewStudentDetails(context, student),
                  onEdit: (student) => _editStudent(context, student),
                  onDelete: (student) => _deleteStudent(context, student),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addStudent(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _viewStudentDetails(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(student: student),
      ),
    );
  }

  void _editStudent(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentFormScreen(student: student),
      ),
    );
  }

  void _addStudent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentFormScreen()),
    );
  }

  void _deleteStudent(BuildContext context, Student student) async {
    final confirm = await Dialogs.showConfirmationDialog(
      context: context,
      title: 'Delete Student',
      content: 'Are you sure you want to delete this student?',
    );

    if (confirm) {
      await Provider.of<StudentProvider>(
        context,
        listen: false,
      ).deleteStudent(student.id!);
    }
  }
}
