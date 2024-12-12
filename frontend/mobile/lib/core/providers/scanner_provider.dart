import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

enum ScannerState { initial, loading, success, error }

class ScannerProvider with ChangeNotifier {
  File? _imageFile;
  String? _scanResult;
  ScannerState _state = ScannerState.initial;
  String? _errorMessage;

  // Getters
  File? get imageFile => _imageFile;
  String? get scanResult => _scanResult;
  ScannerState get state => _state;
  String? get errorMessage => _errorMessage;

  // Check if currently in loading state
  bool get isLoading => _state == ScannerState.loading;

  // Check if scan was successful
  bool get isSuccess => _state == ScannerState.success;

  Future<void> takePicture(File imageFile) async {
    try {
      // Reset previous state
      _state = ScannerState.loading;
      _errorMessage = null;
      _imageFile = imageFile;
      _scanResult = null;
      notifyListeners();

      // Upload image to backend
      await _uploadImageToBackend(imageFile);
    } catch (e) {
      // Handle any unexpected errors
      _state = ScannerState.error;
      _errorMessage = 'Failed to process image: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> _uploadImageToBackend(File imageFile) async {
    try {
      // Replace with your actual backend URL
      final uri = Uri.parse('https://your-backend-url.com/upload');

      // Create multipart request
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      // Send request
      final response = await request.send();

      // Check response
      if (response.statusCode == 200) {
        // Parse the response
        final responseBody = await response.stream.bytesToString();

        // Update state
        _scanResult = responseBody;
        _state = ScannerState.success;
        notifyListeners();
      } else {
        // Handle unsuccessful response
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle upload errors
      _state = ScannerState.error;
      _errorMessage = 'Error uploading image: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  void clearScan() {
    // Reset to initial state
    _imageFile = null;
    _scanResult = null;
    _errorMessage = null;
    _state = ScannerState.initial;
    notifyListeners();
  }
}
