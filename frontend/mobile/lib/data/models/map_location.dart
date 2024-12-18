import 'package:latlong2/latlong.dart';

class MapLocation {
  final LatLng? startLocation;
  final LatLng? endLocation;
  final String startAddress;
  final String endAddress;
  final List<LatLng>? routePoints;
  final double? routeDistance;
  final double? routeDuration;

  const MapLocation({
    this.startLocation,
    this.endLocation,
    this.startAddress = '',
    this.endAddress = '',
    this.routePoints,
    this.routeDistance,
    this.routeDuration,
  });

  MapLocation copyWith({
    LatLng? startLocation,
    LatLng? endLocation,
    String? startAddress,
    String? endAddress,
    List<LatLng>? routePoints,
    double? routeDistance,
    double? routeDuration,
  }) {
    return MapLocation(
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      startAddress: startAddress ?? this.startAddress,
      endAddress: endAddress ?? this.endAddress,
      routePoints: routePoints ?? this.routePoints,
      routeDistance: routeDistance ?? this.routeDistance,
      routeDuration: routeDuration ?? this.routeDuration,
    );
  }
}
