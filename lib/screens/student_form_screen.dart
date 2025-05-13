import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/models/student_model.dart';
import 'package:student_management_provider/providers/image_provider.dart';
import 'package:student_management_provider/utils/validators.dart';
import 'package:student_management_provider/widgets/student_form_controller.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student;

  const StudentFormScreen({super.key, this.student});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final StudentFormController _controller = StudentFormController();

  @override
  void initState() {
    super.initState();
    _controller.initControllers(widget.student, context);
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);
    final imageFile = imageProvider.image;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _controller.saveStudent(context, widget.student),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _controller.pickImage(context),
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
                controller: _controller.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: Validators.validateName,
              ),
              TextFormField(
                controller: _controller.ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: Validators.validateAge,
              ),
              TextFormField(
                controller: _controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              TextFormField(
                controller: _controller.phoneController,
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
