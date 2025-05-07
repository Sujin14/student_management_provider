import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.isEditing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(isEditing ? 'Update' : 'Save'),
    );
  }
}
