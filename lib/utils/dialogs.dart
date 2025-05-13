import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('confirm'),
              ),
            ],
          ),
    );
    return result ?? false;
  }
}
