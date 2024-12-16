class FleetStatsEntity {
  final int totalVehicles;
  final int electricVehicles;
  final int availableVehicles;
  final int rentedVehicles;

  const FleetStatsEntity({
    required this.totalVehicles,
    required this.electricVehicles,
    required this.availableVehicles,
    required this.rentedVehicles,
  });
}
