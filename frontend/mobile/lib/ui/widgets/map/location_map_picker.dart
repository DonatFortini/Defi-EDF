import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mobile/domain/location_controller.dart';
import 'package:mobile/ui/widgets/map/location_info_cart.dart';

class LocationMapPicker extends StatelessWidget {
  final LocationController controller;

  const LocationMapPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // La carte avec ses contrôles
        Stack(
          children: [
            SizedBox(
              height: 300,
              child: FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: LocationController.corsicaCenter,
                  initialZoom: LocationController.initialZoom,
                  maxZoom: 18,
                  minZoom: 6,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LocationController.corsicaBounds,
                  ),
                  onTap: controller.handleMapTap,
                  keepAlive: true,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      if (controller.location.startLocation != null)
                        Marker(
                          point: controller.location.startLocation!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      if (controller.location.endLocation != null)
                        Marker(
                          point: controller.location.endLocation!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                    ],
                  ),
                  if (controller.location.routePoints != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: controller.location.routePoints!,
                          color: Colors.blue,
                          strokeWidth: 3.0,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Boutons de zoom
            Positioned(
              right: 8,
              bottom: 8,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      final currentZoom = controller.mapController.camera.zoom;
                      controller.mapController.move(
                        controller.mapController.camera.center,
                        currentZoom + 1,
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    onPressed: () {
                      final currentZoom = controller.mapController.camera.zoom;
                      controller.mapController.move(
                        controller.mapController.camera.center,
                        currentZoom - 1,
                      );
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
            // Boutons de contrôle
            Positioned(
              top: 8,
              right: 8,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      controller.mapController.move(
                        LocationController.corsicaCenter,
                        LocationController.initialZoom,
                      );
                    },
                    child: const Icon(Icons.my_location),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Carte d'information sous la carte
        if (controller.location.startLocation != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LocationInfoCard(
              location: controller.location,
              onClear: controller.resetMap,
            ),
          ),
      ],
    );
  }
}
