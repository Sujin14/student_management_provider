import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentFormProvider with ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImage(String path) {
    _imagePath = path;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setImage(pickedFile.path);
    }
  }

  void initialize(String? path) {
    _imagePath = path;
  }
}
