// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/utils/navigations.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';

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
            onPressed: () => Navigations.editStudent(context, student),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Navigations.deleteStudent(context, student),
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
}
