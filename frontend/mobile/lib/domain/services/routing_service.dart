import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class RoutingService {
  static const String _apiKey = 'f5388886-41d3-49a0-bc93-76b67e614119';

  static Future<Map<String, dynamic>?> calculateRoute(
    LatLng start,
    LatLng end,
  ) async {
    final url = Uri.parse(
      'https://graphhopper.com/api/1/route'
      '?point=${start.latitude},${start.longitude}'
      '&point=${end.latitude},${end.longitude}'
      '&vehicle=car'
      '&locale=fr'
      '&calc_points=true'
      '&points_encoded=false'
      '&key=$_apiKey',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        debugPrint('Erreur API GraphHopper: ${response.statusCode}');
        return null;
      }

      final data = json.decode(response.body);
      if (data['paths'] == null || data['paths'].isEmpty) {
        debugPrint('Aucune route trouvée');
        return null;
      }

      final path = data['paths'][0];
      final points = path['points']['coordinates'] as List;
      final routePoints =
          points.map<LatLng>((point) {
            return LatLng(point[1].toDouble(), point[0].toDouble());
          }).toList();

      final time = path['time'] as num;
      final distance = path['distance'] as num;

      return {
        'points': routePoints,
        'duration': '${(time / (1000 * 60)).round()} min',
        'distance': '${(distance / 1000).toStringAsFixed(1)} km',
      };
    } catch (e) {
      debugPrint('Erreur lors du calcul de la route: $e');
      return null;
    }
  }
}
