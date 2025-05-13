import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/student_model.dart';
import '../providers/image_provider.dart';
import '../providers/student_provider.dart';

class StudentFormController with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void initControllers(Student? student, BuildContext context) {
    nameController.text = student?.name ?? '';
    ageController.text = student?.age.toString() ?? '';
    emailController.text = student?.email ?? '';
    phoneController.text = student?.phone ?? '';

    final imageProvider = Provider.of<ImagePickerProvider>(
      context,
      listen: false,
    );
    if (student != null) {
      imageProvider.setImage(File(student.imagePath));
    } else {
      imageProvider.clearImage();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<ImagePickerProvider>(
        context,
        listen: false,
      ).setImage(File(pickedFile.path));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No image selected')));
    }
  }

  Future<void> saveStudent(BuildContext context, Student? student) async {
    if (formKey.currentState?.validate() ?? false) {
      final imageProvider = Provider.of<ImagePickerProvider>(
        context,
        listen: false,
      );

      final newStudent = Student(
        id: student?.id,
        name: nameController.text,
        age: int.parse(ageController.text),
        email: emailController.text,
        phone: phoneController.text,
        imagePath: imageProvider.image.path,
      );

      final provider = Provider.of<StudentProvider>(context, listen: false);
      if (student == null) {
        await provider.addStudent(newStudent);
      } else {
        await provider.updateStudent(newStudent);
      }

      Navigator.pop(context);
    }
  }

  void disposeControllers() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }
}
