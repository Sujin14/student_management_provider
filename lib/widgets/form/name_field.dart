import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Name'),
      validator:
          (value) => value == null || value.isEmpty ? 'Enter name' : null,
    );
  }
}
