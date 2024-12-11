import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phoneNumber = '+1 (555) 123-4567';
  String _driverLicense = 'DL12345678';

  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get driverLicense => _driverLicense;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updatePhoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void updateDriverLicense(String newDriverLicense) {
    _driverLicense = newDriverLicense;
    notifyListeners();
  }
}
