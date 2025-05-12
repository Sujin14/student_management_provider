// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';
import '../utils/dialogs.dart';
import '../widgets/student_form.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editStudent(context, student),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteStudent(context, student),
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          final updatedStudent = provider.students.firstWhere(
            (s) => s.id == student.id,
            orElse: () => student,
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(updatedStudent.imagePath)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Name: ${updatedStudent.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Age: ${updatedStudent.age}'),
                Text('Email: ${updatedStudent.email}'),
                Text('Phone: ${updatedStudent.phone}'),
              ],
            ),
          );
        },
      ),
    );
  }

  void _editStudent(BuildContext context, Student? student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentFormScreen(student: student),
      ),
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
      Navigator.pop(context);
    }
  }
}
