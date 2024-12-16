import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mobile/data/models/map_location.dart';
import 'package:mobile/domain/location_controller.dart';
import 'package:mobile/ui/widgets/map/location_info_cart.dart';
import 'package:mobile/ui/widgets/map/map_controls.dart';

class LocationMapPicker extends StatelessWidget {
  final LocationController controller;

  const LocationMapPicker({super.key, required this.controller});

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Comment utiliser la carte'),
            content: const SingleChildScrollView(
              child: Text(
                'Pour sélectionner votre itinéraire :\n\n'
                '1. Tapez sur la carte pour placer le point de départ (vert)\n'
                '2. Tapez à nouveau pour placer le point d\'arrivée (rouge)\n\n'
                'L\'itinéraire le plus rapide sera automatiquement calculé.\n\n'
                'Utilisez les boutons pour :\n'
                '• Réinitialiser la carte\n'
                '• Recentrer sur votre position\n'
                '• Afficher cette aide',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Compris'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Sélectionnez vos points de départ et d\'arrivée en Corse',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        LocationInfoCard(location: controller.location),
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: LocationController.corsicaCenter,
                  initialZoom: LocationController.initialZoom,
                  minZoom: 8,
                  maxZoom: 18,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LocationController.corsicaBounds,
                  ),
                  onTap: controller.handleMapTap,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  if (controller.location.routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: controller.location.routePoints,
                          color: Colors.blue,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  MarkerLayer(markers: _buildMarkers(controller.location)),
                ],
              ),
              Positioned(
                top: 16,
                right: 16,
                child: MapControls(
                  onReset: controller.resetMap,
                  onLocate: controller.initializeLocation,
                  onHelp: () => _showHelpDialog(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Marker> _buildMarkers(MapLocation location) {
    final markers = <Marker>[];

    if (location.startLocation != null) {
      markers.add(
        Marker(
          point: location.startLocation!,
          child: const Icon(Icons.location_on, color: Colors.green, size: 40),
        ),
      );
    }

    if (location.endLocation != null) {
      markers.add(
        Marker(
          point: location.endLocation!,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
      );
    }

    return markers;
  }
}
