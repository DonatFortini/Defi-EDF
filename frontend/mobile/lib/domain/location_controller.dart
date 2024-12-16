import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile/data/models/map_location.dart';
import 'package:mobile/domain/services/geocoding_service.dart';
import 'package:mobile/domain/services/location_service.dart';
import 'package:mobile/domain/services/routing_service.dart';

class LocationController extends ChangeNotifier {
  static const LatLng corsicaCenter = LatLng(42.039604, 9.012893);
  static const double initialZoom = 9.0;
  static final LatLngBounds corsicaBounds = LatLngBounds(
    const LatLng(41.3, 8.5),
    const LatLng(43.0, 9.5),
  );

  MapLocation _location = const MapLocation();
  final MapController mapController = MapController();

  MapLocation get location => _location;

  Future<void> initializeLocation() async {
    if (await LocationService.checkAndRequestPermissions()) {
      final userPosition = await LocationService.getCurrentLocation();
      if (userPosition != null && corsicaBounds.contains(userPosition)) {
        mapController.move(userPosition, initialZoom);
      } else {
        mapController.move(corsicaCenter, initialZoom);
      }
    }
  }

  Future<void> handleMapTap(TapPosition tapPosition, LatLng point) async {
    if (!corsicaBounds.contains(point)) return;

    if (_location.startLocation == null) {
      final address = await GeocodingService.getAddressFromLatLng(point);
      _location = _location.copyWith(
        startLocation: point,
        startAddress: address,
      );
      notifyListeners();
    } else if (_location.endLocation == null) {
      final address = await GeocodingService.getAddressFromLatLng(point);
      _location = _location.copyWith(endLocation: point, endAddress: address);
      await _calculateRoute();
      notifyListeners();
    }
  }

  Future<void> _calculateRoute() async {
    if (_location.startLocation == null || _location.endLocation == null)
      return;

    final routeData = await RoutingService.calculateRoute(
      _location.startLocation!,
      _location.endLocation!,
    );

    if (routeData != null) {
      _location = _location.copyWith(
        routePoints: routeData['points'],
        routeDuration: routeData['duration'],
        routeDistance: routeData['distance'],
      );
      notifyListeners();
    }
  }

  void resetMap() {
    _location = const MapLocation();
    notifyListeners();
  }
}
