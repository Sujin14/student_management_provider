import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: const Text('Delete Student'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text("Confirm", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
  );
}
