import 'package:frontend/features/home/domain/entities/fleet_entities.dart';

class FleetStatsModel extends FleetStatsEntity {
  const FleetStatsModel({
    required super.totalVehicles,
    required super.electricVehicles,
    required super.availableVehicles,
    required super.rentedVehicles,
  });

  factory FleetStatsModel.fromJson(Map<String, dynamic> json) {
    return FleetStatsModel(
      totalVehicles:
          json['propulsion']['electric'] + json['propulsion']['thermic'],
      electricVehicles: json['propulsion']['electric'],
      availableVehicles: json['dispo']['free'],
      rentedVehicles: json['dispo']['leased'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propulsion': {
        'electric': electricVehicles,
        'thermic': totalVehicles - electricVehicles,
      },
      'dispo': {
        'free': availableVehicles,
        'leased': rentedVehicles,
      }
    };
  }
}
