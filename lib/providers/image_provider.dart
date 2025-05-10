import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier {
  File _image = File('');
  File get image => _image;

  void setImage(File imageFile) {
    _image = imageFile;
    notifyListeners();
  }

  void clearImage() {
    _image = File('');
    notifyListeners();
  }
}
