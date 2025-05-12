import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/utils/navigations.dart';
import '../providers/student_provider.dart';
import '../widgets/student_list_view.dart';
import '../widgets/student_grid_view.dart';

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
                  onTap:
                      (student) =>
                          Navigations.viewStudentDetails(context, student),
                  onEdit:
                      (student) => Navigations.editStudent(context, student),
                  onDelete:
                      (student) => Navigations.deleteStudent(context, student),
                )
                : StudentListView(
                  students: students,
                  onTap:
                      (student) =>
                          Navigations.viewStudentDetails(context, student),
                  onEdit:
                      (student) => Navigations.editStudent(context, student),
                  onDelete:
                      (student) => Navigations.deleteStudent(context, student),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigations.addStudent(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
