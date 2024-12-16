import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  static final Location _location = Location();

  static Future<bool> checkAndRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    var permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return false;
    }

    return true;
  }

  static Future<LatLng?> getCurrentLocation() async {
    try {
      final currentLocation = await _location.getLocation();
      return LatLng(currentLocation.latitude!, currentLocation.longitude!);
    } catch (e) {
      debugPrint('Erreur de localisation: $e');
      return null;
    }
  }
}
