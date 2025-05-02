import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
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
