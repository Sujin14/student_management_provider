import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/student_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Management',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const StudentListScreen(),
      ),
    );
  }
}
