import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/providers/image_provider.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';
import '../utils/validators.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student;

  const StudentFormScreen({super.key, this.student});

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _ageController = TextEditingController(
      text: widget.student?.age.toString() ?? '',
    );
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _phoneController = TextEditingController(text: widget.student?.phone ?? '');

    if (widget.student != null) {
      final imageProvider = Provider.of<ImagePickerProvider>(
        context,
        listen: false,
      );
      imageProvider.setImage(File(widget.student!.imagePath));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    final imageProvider = Provider.of<ImagePickerProvider>(
      context,
      listen: false,
    );
    if (_formKey.currentState?.validate() ?? false) {
      final newStudent = Student(
        id: widget.student?.id,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        email: _emailController.text,
        phone: _phoneController.text,
        imagePath: imageProvider.image.path,
      );

      final provider = Provider.of<StudentProvider>(context, listen: false);
      if (widget.student == null) {
        await provider.addStudent(newStudent);
      } else {
        await provider.updateStudent(newStudent);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageProvider = Provider.of<ImagePickerProvider>(
        context,
        listen: false,
      );
      imageProvider.setImage(File(pickedFile.path));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No image selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);
    final imageFile = imageProvider.image;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveStudent),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      imageFile.path.isNotEmpty ? FileImage(imageFile) : null,
                  child:
                      imageFile.path.isEmpty
                          ? const Icon(Icons.account_circle, size: 60)
                          : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: Validators.validateName,
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: Validators.validateAge,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
