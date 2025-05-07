import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No students found.',
        style: const TextStyle(fontSize: 18, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
