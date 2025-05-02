import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/add_edit_student_screen.dart';
import 'package:student_management_provider/widgets/confirm_dialog.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentModel student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
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
            icon: const Icon(Icons.delete),
            onPressed:
                () => showConfirmDialog(
                  context: context,
                  title: "Delete Student",
                  content: "Are you sure you want to delete this student?",
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
      body: Consumer<StudentProvider>(
        builder: (context, provider, _) {
          // Get the updated student details
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
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
