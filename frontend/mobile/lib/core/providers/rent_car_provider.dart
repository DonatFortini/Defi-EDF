import 'package:flutter/foundation.dart';

class RentalProvider with ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCar;
  List<String> _additionalServices = [];

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? get selectedCar => _selectedCar;
  List<String> get additionalServices => _additionalServices;

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
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
    _selectedCar = null;
    _additionalServices = [];
    notifyListeners();
  }
}
