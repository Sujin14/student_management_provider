import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_provider/models/student_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            email TEXT,
            phone INTEGER,
            imagePath TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertStudent(StudentModel student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('students');
    return result.map((e) => StudentModel.fromMap(e)).toList();
  }

  Future<int> updateStudent(StudentModel student) async {
    final db = await database;
    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
