import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class GeocodingService {
  static Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street ?? ''}, ${place.locality ?? ''}, ${place.postalCode ?? ''}'
            .replaceAll(RegExp(r', ,'), ',')
            .replaceAll(RegExp(r'^, |, $'), '');
      }
    } catch (e) {
      debugPrint('Erreur de géocodage: $e');
    }
    return 'Adresse inconnue';
  }
}
