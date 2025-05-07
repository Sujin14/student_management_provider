import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/widgets/form/profile_image_picker.dart';
import 'package:student_management_provider/widgets/form/name_field.dart';
import 'package:student_management_provider/widgets/form/age_field.dart';
import 'package:student_management_provider/widgets/form/email_field.dart';
import 'package:student_management_provider/widgets/form/phone_field.dart';
import 'package:student_management_provider/widgets/form/save_button.dart';
import 'package:student_management_provider/providers/student_form_provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/student_provider.dart';

class StudentForm extends StatefulWidget {
  final StudentModel? student;

  const StudentForm({super.key, this.student});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _ageController = TextEditingController(
      text: widget.student?.age.toString() ?? '',
    );
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _phoneController = TextEditingController(
      text: widget.student?.phone.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveStudent(BuildContext context) {
    final imagePath =
        Provider.of<StudentFormProvider>(context, listen: false).imagePath;

    if (!_formKey.currentState!.validate() || imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select an image'),
        ),
      );
      return;
    }

    final student = StudentModel(
      id: widget.student?.id,
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      email: _emailController.text.trim(),
      phone: int.parse(_phoneController.text.trim()),
      imagePath: imagePath,
    );

    final provider = Provider.of<StudentProvider>(context, listen: false);
    if (widget.student == null) {
      provider.addStudent(student);
    } else {
      provider.updateStudent(student);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student saved successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const ProfileImagePicker(),
            const SizedBox(height: 16),
            NameField(controller: _nameController),
            const SizedBox(height: 10),
            AgeField(controller: _ageController),
            const SizedBox(height: 10),
            EmailField(controller: _emailController),
            const SizedBox(height: 10),
            PhoneField(controller: _phoneController),
            const SizedBox(height: 20),
            SaveButton(
              isEditing: isEditing,
              onPressed: () => _saveStudent(context),
            ),
          ],
        ),
      ),
    );
  }
}
