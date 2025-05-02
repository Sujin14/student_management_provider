import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
