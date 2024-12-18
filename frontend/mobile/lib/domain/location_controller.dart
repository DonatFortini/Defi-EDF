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
    const LatLng(41.0, 8.0),
    const LatLng(43.5, 10.0),
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
    if (!corsicaBounds.contains(point)) {
      print('Point hors des limites de la Corse');
      return;
    }

    print('Tap détecté à : $point');

    if (_location.startLocation == null) {
      print('Définition du point de départ');
      final address = await GeocodingService.getAddressFromLatLng(point);
      print('Adresse trouvée : $address');
      _location = _location.copyWith(
        startLocation: point,
        startAddress: address,
      );
      notifyListeners();
    } else if (_location.endLocation == null) {
      print('Définition du point d\'arrivée');
      final address = await GeocodingService.getAddressFromLatLng(point);
      print('Adresse trouvée : $address');
      _location = _location.copyWith(endLocation: point, endAddress: address);
      await _calculateRoute();
      notifyListeners();
    }
  }

  // Dans LocationController
  Future<void> _calculateRoute() async {
    if (_location.startLocation == null || _location.endLocation == null) {
      print('Points de départ ou d\'arrivée manquants');
      return;
    }

    print(
      'Calcul de l\'itinéraire entre ${_location.startLocation} et ${_location.endLocation}',
    );

    final routeData = await RoutingService.calculateRoute(
      _location.startLocation!,
      _location.endLocation!,
    );

    if (routeData != null) {
      try {
        // Conversion explicite des valeurs
        final double? duration =
            routeData['duration'] != null
                ? double.tryParse(routeData['duration'].toString())
                : null;

        final double? distance =
            routeData['distance'] != null
                ? double.tryParse(routeData['distance'].toString())
                : null;

        print('Route calculée - Duration: $duration, Distance: $distance');

        _location = _location.copyWith(
          routePoints: routeData['points'] as List<LatLng>?,
          routeDuration: duration,
          routeDistance: distance,
        );
        notifyListeners();
      } catch (e) {
        print('Erreur lors du traitement des données de route: $e');
      }
    }
  }

  void resetMap() {
    _location = const MapLocation();
    notifyListeners();
  }
}
