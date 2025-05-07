import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/add_edit_student_screen.dart';
import 'package:student_management_provider/screens/student_detail_screen.dart';
import 'package:student_management_provider/widgets/form/common/empty_message.dart';
import 'package:student_management_provider/widgets/search/search_bar.dart';
import 'package:student_management_provider/widgets/layout/student_grid_card.dart';
import 'package:student_management_provider/widgets/layout/student_list_card.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
    final students = provider.filteredStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Records'),
        backgroundColor: const Color.fromARGB(255, 235, 130, 9),
        actions: [
          IconButton(
            icon: Icon(provider.isGrid ? Icons.list : Icons.grid_view),
            onPressed: provider.toggleViewMode,
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
              child: CustomSearchBar(onChanged: provider.updateSearchQuery),
            ),
            Expanded(
              child:
                  students.isEmpty
                      ? const EmptyMessage()
                      : provider.isGrid
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
                            onTap: () => _openDetail(context, student),
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
                              onTap: () => _openDetail(context, student),
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

  void _openDetail(BuildContext context, StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StudentDetailScreen(student: student)),
    );
  }
}
