import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }
}
