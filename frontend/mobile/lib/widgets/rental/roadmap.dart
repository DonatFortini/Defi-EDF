import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationMapPicker extends StatefulWidget {
  const LocationMapPicker({super.key});

  @override
  State<LocationMapPicker> createState() => _LocationMapPickerState();
}

class _LocationMapPickerState extends State<LocationMapPicker> {
  final mapController = MapController();
  LatLng? startLocation;
  LatLng? endLocation;
  String startAddress = '';
  String endAddress = '';
  final List<Marker> markers = [];
  List<LatLng> routePoints = [];
  String routeDuration = '';
  String routeDistance = '';

  // Définir les coordonnées centrales de la Corse
  static const initialPosition = LatLng(42.039604, 9.012893);

  // Définir les limites de la carte (bounds de la Corse)
  static final LatLngBounds corseBounds = LatLngBounds(
    const LatLng(41.3, 8.5), // Sud-Ouest
    const LatLng(43.0, 9.5), // Nord-Est
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getRoute() async {
    if (startLocation == null || endLocation == null) return;

    final String url = 'http://router.project-osrm.org/route/v1/driving/'
        '${startLocation!.longitude},${startLocation!.latitude};'
        '${endLocation!.longitude},${endLocation!.latitude}'
        '?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final route = data['routes'][0];

        final geometry = route['geometry']['coordinates'] as List;
        routePoints = geometry.map((point) {
          return LatLng(point[1].toDouble(), point[0].toDouble());
        }).toList();

        final duration = (route['duration'] as num).toDouble();
        final distance = (route['distance'] as num).toDouble();

        setState(() {
          routeDuration = '${(duration / 60).round()} min';
          routeDistance = '${(distance / 1000).toStringAsFixed(1)} km';
        });
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la route: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final currentLocation = await location.getLocation();
    final currentLatLng = LatLng(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );

    // Vérifier si la position actuelle est dans les limites de la Corse
    if (corseBounds.contains(currentLatLng)) {
      mapController.move(currentLatLng, 10);
    } else {
      // Si hors de la Corse, centrer sur la position initiale
      mapController.move(initialPosition, 10);
    }
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.postalCode}';
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
    return 'Adresse inconnue';
  }

  void _updateMarkers() async {
    markers.clear();

    if (startLocation != null) {
      markers.add(
        Marker(
          point: startLocation!,
          child: const Icon(
            Icons.location_on,
            color: Colors.green,
            size: 40,
          ),
        ),
      );
    }

    if (endLocation != null) {
      markers.add(
        Marker(
          point: endLocation!,
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ),
      );

      if (startLocation != null) {
        await _getRoute();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sélectionnez vos points de départ et d\'arrivée en Corse',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (startAddress.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.green),
                    title: const Text('Point de départ'),
                    subtitle: Text(startAddress),
                  ),
                if (endAddress.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.red),
                    title: const Text('Point d\'arrivée'),
                    subtitle: Text(endAddress),
                  ),
                if (routeDuration.isNotEmpty && routeDistance.isNotEmpty)
                  ListTile(
                    leading:
                        const Icon(Icons.directions_car, color: Colors.blue),
                    title: const Text('Itinéraire'),
                    subtitle: Text(
                        'Durée: $routeDuration - Distance: $routeDistance'),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: initialPosition,
                  initialZoom: 9,
                  minZoom: 8, // Limite le zoom minimum
                  maxZoom: 18, // Limite le zoom maximum
                  // Définir les limites de la carte
                  cameraConstraint:
                      CameraConstraint.contain(bounds: corseBounds),
                  onTap: (tapPosition, point) async {
                    // Vérifier si le point cliqué est dans les limites de la Corse
                    if (corseBounds.contains(point)) {
                      if (startLocation == null) {
                        startLocation = point;
                        startAddress = await _getAddressFromLatLng(point);
                      } else if (endLocation == null) {
                        endLocation = point;
                        endAddress = await _getAddressFromLatLng(point);
                      }
                      _updateMarkers();
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  PolylineLayer(
                    polylines: [
                      if (routePoints.isNotEmpty)
                        Polyline(
                          points: routePoints,
                          color: Colors.blue,
                          strokeWidth: 3,
                        ),
                    ],
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'clear_button',
                      onPressed: () {
                        setState(() {
                          startLocation = null;
                          endLocation = null;
                          startAddress = '';
                          endAddress = '';
                          markers.clear();
                          routePoints.clear();
                          routeDuration = '';
                          routeDistance = '';
                        });
                      },
                      child: const Icon(Icons.clear),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'location_button',
                      onPressed: _getCurrentLocation,
                      child: const Icon(Icons.my_location),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'help_button',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Comment utiliser la carte'),
                            content: const Text(
                              'Tapez sur la carte de la Corse pour placer :\n'
                              '1. Le point de départ (marqueur vert)\n'
                              '2. Le point d\'arrivée (marqueur rouge)\n\n'
                              'L\'itinéraire le plus rapide sera automatiquement calculé.\n\n'
                              'Utilisez les boutons pour :\n'
                              '- Effacer les marqueurs et l\'itinéraire\n'
                              '- Centrer sur votre position\n',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Compris'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(Icons.help),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
