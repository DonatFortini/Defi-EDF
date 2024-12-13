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
  // Controllers
  final MapController _mapController = MapController();

  // Location data
  LatLng? _startLocation;
  LatLng? _endLocation;
  String _startAddress = '';
  String _endAddress = '';

  // Route data
  final List<Marker> _markers = [];
  List<LatLng> _routePoints = [];
  String _routeDuration = '';
  String _routeDistance = '';

  // Constants
  static const LatLng _corsicaCenter = LatLng(42.039604, 9.012893);
  static const double _initialZoom = 9.0;
  static final LatLngBounds _corsicaBounds = LatLngBounds(
    const LatLng(41.3, 8.5), // Sud-Ouest
    const LatLng(43.0, 9.5), // Nord-Est
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final location = Location();

    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      var permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) return;
      }

      final currentLocation = await location.getLocation();
      final userPosition = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      if (mounted) {
        setState(() {
          if (_corsicaBounds.contains(userPosition)) {
            _mapController.move(userPosition, _initialZoom);
          } else {
            _mapController.move(_corsicaCenter, _initialZoom);
          }
        });
      }
    } catch (e) {
      debugPrint('Erreur de localisation: $e');
      if (mounted) {
        _mapController.move(_corsicaCenter, _initialZoom);
      }
    }
  }

  Future<void> _calculateRoute() async {
    if (_startLocation == null || _endLocation == null) return;

    // Clé API GraphHopper - Remplacez par votre propre clé
    const apiKey = 'f5388886-41d3-49a0-bc93-76b67e614119';

    final url = Uri.parse('https://graphhopper.com/api/1/route'
        '?point=${_startLocation!.latitude},${_startLocation!.longitude}'
        '&point=${_endLocation!.latitude},${_endLocation!.longitude}'
        '&vehicle=car'
        '&locale=fr'
        '&calc_points=true'
        '&points_encoded=false'
        '&key=$apiKey');

    try {
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode != 200) {
        debugPrint('Erreur API GraphHopper: ${response.statusCode}');
        return;
      }

      final data = json.decode(response.body);
      if (data['paths'] == null || data['paths'].isEmpty) {
        debugPrint('Aucune route trouvée');
        return;
      }

      final path = data['paths'][0];
      final points = path['points']['coordinates'] as List;
      final time = path['time'] as num;
      final distance = path['distance'] as num;

      setState(() {
        _routePoints = points.map<LatLng>((point) {
          return LatLng(point[1].toDouble(), point[0].toDouble());
        }).toList();

        _routeDuration = '${(time / (1000 * 60)).round()} min';
        _routeDistance = '${(distance / 1000).toStringAsFixed(1)} km';
      });
    } catch (e) {
      debugPrint('Erreur lors du calcul de la route: $e');
    }
  }

  Future<String> _getAddress(LatLng position) async {
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

  void _updateMarkers() async {
    setState(() {
      _markers.clear();
      _routePoints = [];
      _routeDuration = '';
      _routeDistance = '';

      if (_startLocation != null) {
        _markers.add(
          Marker(
            point: _startLocation!,
            child: const Icon(Icons.location_on, color: Colors.green, size: 40),
          ),
        );
      }

      if (_endLocation != null) {
        _markers.add(
          Marker(
            point: _endLocation!,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
      }
    });

    if (_startLocation != null && _endLocation != null) {
      await _calculateRoute();
    }
  }

  void _handleMapTap(TapPosition tapPosition, LatLng point) async {
    if (!_corsicaBounds.contains(point)) return;

    if (_startLocation == null) {
      setState(() => _startLocation = point);
      _startAddress = await _getAddress(point);
    } else if (_endLocation == null) {
      setState(() => _endLocation = point);
      _endAddress = await _getAddress(point);
    } else {
      return;
    }

    _updateMarkers();
  }

  void _resetMap() {
    setState(() {
      _startLocation = null;
      _endLocation = null;
      _startAddress = '';
      _endAddress = '';
      _markers.clear();
      _routePoints = [];
      _routeDuration = '';
      _routeDistance = '';
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comment utiliser la carte'),
        content: const SingleChildScrollView(
          child: Text('Pour sélectionner votre itinéraire :\n\n'
              '1. Tapez sur la carte pour placer le point de départ (vert)\n'
              '2. Tapez à nouveau pour placer le point d\'arrivée (rouge)\n\n'
              'L\'itinéraire le plus rapide sera automatiquement calculé.\n\n'
              'Utilisez les boutons pour :\n'
              '• Réinitialiser la carte\n'
              '• Recentrer sur votre position\n'
              '• Afficher cette aide'),
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
        if (_startAddress.isNotEmpty || _endAddress.isNotEmpty)
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (_startAddress.isNotEmpty)
                    ListTile(
                      leading:
                          const Icon(Icons.location_on, color: Colors.green),
                      title: const Text('Point de départ'),
                      subtitle: Text(_startAddress),
                    ),
                  if (_endAddress.isNotEmpty)
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: const Text('Point d\'arrivée'),
                      subtitle: Text(_endAddress),
                    ),
                  if (_routeDuration.isNotEmpty && _routeDistance.isNotEmpty)
                    ListTile(
                      leading:
                          const Icon(Icons.directions_car, color: Colors.blue),
                      title: const Text('Itinéraire'),
                      subtitle: Text(
                          'Durée: $_routeDuration - Distance: $_routeDistance'),
                    ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _corsicaCenter,
                  initialZoom: _initialZoom,
                  minZoom: 8,
                  maxZoom: 18,
                  cameraConstraint:
                      CameraConstraint.contain(bounds: _corsicaBounds),
                  onTap: _handleMapTap,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  if (_routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: _routePoints,
                          color: Colors.blue,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  MarkerLayer(markers: _markers),
                ],
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'reset_button',
                      onPressed: _resetMap,
                      child: const Icon(Icons.clear),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'location_button',
                      onPressed: _initializeLocation,
                      child: const Icon(Icons.my_location),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'help_button',
                      onPressed: _showHelpDialog,
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
