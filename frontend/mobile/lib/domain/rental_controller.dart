import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile/data/models/rental_booking.dart';
import 'package:mobile/data/models/rental_car.dart';

class RentalController extends ChangeNotifier {
  RentalBooking _booking = const RentalBooking();
  final List<RentalCar> _availableCars = [
    const RentalCar(
      brand: 'Peugeot',
      model: 'e208',
      range: 340,
      seats: 2,
      isElectric: true,
      details: 'Coffre large, Climatisation',
      batteryLevel: 80,
    ),
    const RentalCar(
      brand: 'Honda',
      model: 'Civic',
      range: 550,
      seats: 5,
      isElectric: false,
      details: 'Coffre moyen, GPS intégré',
      fuelLevel: 60,
    ),
  ];

  RentalBooking get booking => _booking;
  List<RentalCar> get availableCars => _availableCars;

  void setStartDate(DateTime date) {
    _booking = _booking.copyWith(startDate: date);
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _booking = _booking.copyWith(endDate: date);
    notifyListeners();
  }

  void setTimeSlot(String timeSlot) {
    _booking = _booking.copyWith(timeSlot: timeSlot);
    notifyListeners();
  }

  void setInterventionDuration(String duration) {
    _booking = _booking.copyWith(interventionDuration: duration);
    notifyListeners();
  }

  void setSelectedSeats(int seats) {
    _booking = _booking.copyWith(selectedSeats: seats);
    notifyListeners();
  }

  void setSelectedCar(String carFullName) {
    final car = _availableCars.firstWhere((car) => car.fullName == carFullName);
    _booking = _booking.copyWith(selectedCar: car);
    notifyListeners();
  }

  void toggleAdditionalService(String service) {
    final services = Set<String>.from(_booking.additionalServices);
    if (services.contains(service)) {
      services.remove(service);
    } else {
      services.add(service);
    }
    _booking = _booking.copyWith(additionalServices: services);
    notifyListeners();
  }

  void setLocations({
    LatLng? startLocation,
    LatLng? endLocation,
    String? startAddress,
    String? endAddress,
  }) {
    _booking = _booking.copyWith(
      startLocation: startLocation,
      endLocation: endLocation,
      startAddress: startAddress,
      endAddress: endAddress,
    );
    notifyListeners();
  }

  void resetForm() {
    _booking = const RentalBooking();
    notifyListeners();
  }
}
