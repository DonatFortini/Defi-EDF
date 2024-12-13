import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:frontend/config/environment.dart';

enum ScannerState { initial, loading, success, error }

class ScannerProvider with ChangeNotifier {
  File? _imageFile;
  String? _plateResult;
  String? _mileageResult;
  ScannerState _state = ScannerState.initial;
  String? _errorMessage;

  // Getters
  File? get imageFile => _imageFile;
  String? get plateResult => _plateResult;
  String? get mileageResult => _mileageResult;
  ScannerState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == ScannerState.loading;
  bool get isSuccess => _state == ScannerState.success;

  Future<void> scanPlate(File imageFile) async {
    _resetState();
    _imageFile = imageFile;
    notifyListeners();

    try {
      final response = await _uploadImageToBackend(
          imageFile, EnvironmentConfig.sendPlateRoute());

      final Map<String, dynamic> jsonResponse = json.decode(response);
      _plateResult = jsonResponse['plate_number'];
      _state = ScannerState.success;
    } catch (e) {
      _handleError(e);
    }
    notifyListeners();
  }

  Future<void> scanMileage(File imageFile) async {
    _resetState();
    _imageFile = imageFile;
    notifyListeners();

    try {
      // Scan du kilométrage
      final response = await _uploadImageToBackend(
          imageFile, EnvironmentConfig.sendMileageRoute());

      final Map<String, dynamic> jsonResponse = json.decode(response);
      _mileageResult = jsonResponse['mileage'];

      if (_mileageResult != "No match found" && _plateResult != null) {
        // Mise à jour du kilométrage si nous avons des données valides
        await _updateVehicleMileage();
      }

      _state = ScannerState.success;
    } catch (e) {
      _handleError(e);
    }
    notifyListeners();
  }

  Future<void> _updateVehicleMileage() async {
    if (_plateResult == null || _mileageResult == null) {
      throw Exception('Numéro de plaque ou kilométrage manquant');
    }

    final request = http.MultipartRequest(
        'POST', Uri.parse(EnvironmentConfig.sendMileageRoute()));

    request.fields['plate'] = _plateResult!;
    request.fields['mileage'] = _mileageResult!;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(
          'Échec de la mise à jour du kilométrage (${response.statusCode}): ${response.body}');
    }
  }

  Future<String> _uploadImageToBackend(File imageFile, String url) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Échec de l\'envoi (${response.statusCode}): ${response.body}');
    }
  }

  void _resetState() {
    _state = ScannerState.loading;
    _errorMessage = null;
  }

  void _handleError(Object e) {
    _state = ScannerState.error;
    _errorMessage = e.toString();
  }

  void clearState() {
    _imageFile = null;
    _plateResult = null;
    _mileageResult = null;
    _errorMessage = null;
    _state = ScannerState.initial;
    notifyListeners();
  }
}
