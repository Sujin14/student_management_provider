import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/student_detail_screen.dart';
import 'package:student_management_provider/utils/dialogs.dart';
import 'package:student_management_provider/widgets/student_form.dart';

class Navigations {
  static void viewStudentDetails(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(student: student),
      ),
    );
  }

  static editStudent(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentFormScreen(student: student),
      ),
    );
  }

  static void addStudent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentFormScreen()),
    );
  }

  static void deleteStudent(BuildContext context, Student student) async {
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
