import 'package:flutter/material.dart';

class AgeField extends StatelessWidget {
  final TextEditingController controller;

  const AgeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        final age = int.tryParse(value ?? '');
        if (age == null || age <= 0 || age > 100) {
          return 'Enter valid age';
        }
        return null;
      },
    );
  }
}
