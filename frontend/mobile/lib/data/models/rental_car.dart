class RentalCar {
  final String brand;
  final String model;
  final int range;
  final int seats;
  final bool isElectric;
  final String details;
  final int batteryLevel;
  final int fuelLevel;
  final bool available;

  const RentalCar({
    required this.brand,
    required this.model,
    required this.range,
    required this.seats,
    required this.isElectric,
    required this.details,
    this.batteryLevel = 0,
    this.fuelLevel = 0,
    this.available = true,
  });

  String get fullName => '$brand $model';
  int get energyLevel => isElectric ? batteryLevel : fuelLevel;
  String get energyType => isElectric ? 'Batterie' : 'Carburant';
}
