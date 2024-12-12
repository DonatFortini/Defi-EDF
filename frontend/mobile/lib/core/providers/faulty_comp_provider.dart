import 'package:flutter/foundation.dart';
import 'dart:io';

class FaultyCompProvider extends ChangeNotifier {
  String _component = '';
  File? _image;

  String get component => _component;
  File? get image => _image;

  void updateComponent(String component) {
    _component = component;
    notifyListeners();
  }

  void updateImage(File image) {
    _image = image;
    notifyListeners();
  }

  void submitReport() {
    debugPrint('Composant: $_component');
    debugPrint('Image: ${_image?.path ?? 'Aucune image jointe'}');
  }
}
