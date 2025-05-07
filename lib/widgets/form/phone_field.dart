import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Phone'),
      keyboardType: TextInputType.phone,
      validator:
          (value) =>
              value != null && value.length == 10
                  ? null
                  : 'Phone must be 10 digits',
    );
  }
}
