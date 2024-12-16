import 'package:latlong2/latlong.dart';

class MapLocation {
  final LatLng? startLocation;
  final LatLng? endLocation;
  final String startAddress;
  final String endAddress;
  final List<LatLng> routePoints;
  final String routeDuration;
  final String routeDistance;

  const MapLocation({
    this.startLocation,
    this.endLocation,
    this.startAddress = '',
    this.endAddress = '',
    this.routePoints = const [],
    this.routeDuration = '',
    this.routeDistance = '',
  });

  MapLocation copyWith({
    LatLng? startLocation,
    LatLng? endLocation,
    String? startAddress,
    String? endAddress,
    List<LatLng>? routePoints,
    String? routeDuration,
    String? routeDistance,
  }) {
    return MapLocation(
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      startAddress: startAddress ?? this.startAddress,
      endAddress: endAddress ?? this.endAddress,
      routePoints: routePoints ?? this.routePoints,
      routeDuration: routeDuration ?? this.routeDuration,
      routeDistance: routeDistance ?? this.routeDistance,
    );
  }
}
