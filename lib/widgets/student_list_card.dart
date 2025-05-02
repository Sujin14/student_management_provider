import 'dart:io';
import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../widgets/confirm_dialog.dart'; // Your custom dialog file

class StudentListCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentListCard({
    super.key,
    required this.student,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(student.imagePath)),
          ),
          title: Text(
            student.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showConfirmDialog(
                    context: context,
                    title: 'Delete Student',
                    content: 'Are you sure you want to delete ${student.name}?',
                    onConfirm: onDelete,
                  );
                },
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
