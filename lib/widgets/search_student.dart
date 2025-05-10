import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

class StudentSearchScreen extends StatelessWidget {
  const StudentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queryController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Students')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: queryController,
              decoration: const InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final query = queryController.text.trim();
                if (query.isNotEmpty) {
                  Provider.of<StudentProvider>(
                    context,
                    listen: false,
                  ).searchStudent(query);
                } else {
                  Provider.of<StudentProvider>(
                    context,
                    listen: false,
                  ).clearSearch();
                }
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
