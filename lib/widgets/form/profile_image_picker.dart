import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/providers/student_form_provider.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = context.watch<StudentFormProvider>().imagePath;

    return GestureDetector(
      onTap: () {
        context.read<StudentFormProvider>().pickImage();
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: imagePath != null ? FileImage(File(imagePath)) : null,
        child:
            imagePath == null ? const Icon(Icons.add_a_photo, size: 30) : null,
      ),
    );
  }
}
