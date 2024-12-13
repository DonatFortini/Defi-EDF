import 'package:flutter/material.dart';

class RentalProvider with ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedCar;
  List<String> _additionalServices = [];

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  TimeOfDay? get startTime => _startTime;
  TimeOfDay? get endTime => _endTime;
  String? get selectedCar => _selectedCar;
  List<String> get additionalServices => _additionalServices;

  get interventionDuration => null;

  get timeSlot => null;

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    _endTime = time;
    notifyListeners();
  }

  void setSelectedCar(String car) {
    _selectedCar = car;
    notifyListeners();
  }

  void toggleAdditionalService(String service) {
    if (_additionalServices.contains(service)) {
      _additionalServices.remove(service);
    } else {
      _additionalServices.add(service);
    }
    notifyListeners();
  }

  void resetForm() {
    _startDate = null;
    _endDate = null;
    _startTime = null;
    _endTime = null;
    _selectedCar = null;
    _additionalServices = [];
    notifyListeners();
  }

  void setTimeSlot(String s) {}

  void setInterventionDate(String value) {}

  void setInterventionDuration(String s) {}
}
