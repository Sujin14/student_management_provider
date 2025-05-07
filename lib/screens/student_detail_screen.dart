import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/add_edit_student_screen.dart';
import 'package:student_management_provider/widgets/form/common/confirm_dialog.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentModel student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFded93e),
        title: const Text("Student Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditStudentScreen(student: student),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed:
                () => showConfirmDialog(
                  context: context,
                  onConfirm: () {
                    Provider.of<StudentProvider>(
                      context,
                      listen: false,
                    ).deleteStudent(student.id!);
                    Navigator.pop(context);
                  },
                ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFded93e),
        child: Consumer<StudentProvider>(
          builder: (context, provider, _) {
            final updatedStudent = provider.getStudentById(student.id!);

            if (updatedStudent == null) {
              return const Center(child: Text('Student not found.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(File(updatedStudent.imagePath)),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow("Name", updatedStudent.name),
                  _buildDetailRow("Age", updatedStudent.age.toString()),
                  _buildDetailRow("Email", updatedStudent.email),
                  _buildDetailRow("Phone", updatedStudent.phone.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFF104210),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFFf6a21e),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
