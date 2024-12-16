class FleetStatsModel {
  final int totalVehicles;
  final int electricVehicles;
  final int availableVehicles;
  final int rentedVehicles;

  const FleetStatsModel({
    required this.totalVehicles,
    required this.electricVehicles,
    required this.availableVehicles,
    required this.rentedVehicles,
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
      'dispo': {'free': availableVehicles, 'leased': rentedVehicles},
    };
  }
}
