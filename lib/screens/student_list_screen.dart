import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/add_edit_student_screen.dart';
import 'package:student_management_provider/screens/student_detail_screen.dart';
import 'package:student_management_provider/widgets/empty_message.dart';
import 'package:student_management_provider/widgets/search_bar.dart';
import 'package:student_management_provider/widgets/student_grid_card.dart';
import 'package:student_management_provider/widgets/student_list_card.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  bool isGrid = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<StudentProvider>(context, listen: false).fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
    final students = provider.searchStudents(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Records'),
        backgroundColor: const Color.fromARGB(255, 235, 130, 9),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() => isGrid = !isGrid);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditStudentScreen()),
            ),
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 235, 130, 9),
              const Color.fromARGB(255, 218, 232, 18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CustomSearchBar(
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            Expanded(
              child:
                  students.isEmpty
                      ? EmptyMessage()
                      : isGrid
                      ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          return StudentGridCard(
                            student: student,
                            onTap: () => _openDetail(student),
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => AddEditStudentScreen(
                                        student: student,
                                      ),
                                ),
                              );
                            },
                            onDelete: () {
                              provider.deleteStudent(student.id!);
                            },
                          );
                        },
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: StudentListCard(
                              student: student,
                              onTap: () => _openDetail(student),
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => AddEditStudentScreen(
                                          student: student,
                                        ),
                                  ),
                                );
                              },
                              onDelete: () {
                                provider.deleteStudent(student.id!);
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StudentDetailScreen(student: student)),
    );
  }
}
