import 'package:flutter/material.dart';
import 'package:student_management_provider/widgets/form/student_form.dart';
import '../models/student_model.dart';

class AddEditStudentScreen extends StatelessWidget {
  final StudentModel? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  Widget build(BuildContext context) {
    final isEditing = student != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Student" : "Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StudentForm(student: student),
      ),
    );
  }
}
