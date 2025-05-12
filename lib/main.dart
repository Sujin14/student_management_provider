import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/providers/image_provider.dart';
import 'package:student_management_provider/providers/student_provider.dart';
import 'package:student_management_provider/screens/student_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Record Manager',
        theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
        home: const StudentListScreen(),
      ),
    );
  }
}
