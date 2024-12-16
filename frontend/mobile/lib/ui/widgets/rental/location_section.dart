// ui/widgets/rental/location_section.dart
import 'package:flutter/material.dart';
import 'package:mobile/domain/location_controller.dart';
import 'package:mobile/ui/widgets/map/location_map_picker.dart';

class LocationSection extends StatelessWidget {
  LocationSection({super.key});

  final LocationController locationController = LocationController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Localisation', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        LocationMapPicker(controller: locationController),
      ],
    );
  }
}
