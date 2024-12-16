import 'rental_car.dart';
import 'package:latlong2/latlong.dart';

class RentalBooking {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? timeSlot;
  final String? interventionDuration;
  final RentalCar? selectedCar;
  final int selectedSeats;
  final Set<String> additionalServices;
  final LatLng? startLocation;
  final LatLng? endLocation;
  final String startAddress;
  final String endAddress;

  const RentalBooking({
    this.startDate,
    this.endDate,
    this.timeSlot,
    this.interventionDuration,
    this.selectedCar,
    this.selectedSeats = 1,
    this.additionalServices = const {},
    this.startLocation,
    this.endLocation,
    this.startAddress = '',
    this.endAddress = '',
  });

  RentalBooking copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? timeSlot,
    String? interventionDuration,
    RentalCar? selectedCar,
    int? selectedSeats,
    Set<String>? additionalServices,
    LatLng? startLocation,
    LatLng? endLocation,
    String? startAddress,
    String? endAddress,
  }) {
    return RentalBooking(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      timeSlot: timeSlot ?? this.timeSlot,
      interventionDuration: interventionDuration ?? this.interventionDuration,
      selectedCar: selectedCar ?? this.selectedCar,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      additionalServices: additionalServices ?? this.additionalServices,
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      startAddress: startAddress ?? this.startAddress,
      endAddress: endAddress ?? this.endAddress,
    );
  }
}
