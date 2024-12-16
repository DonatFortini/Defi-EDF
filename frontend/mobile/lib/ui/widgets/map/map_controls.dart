import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onLocate;
  final VoidCallback onHelp;

  const MapControls({
    super.key,
    required this.onReset,
    required this.onLocate,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: 'reset_button',
          onPressed: onReset,
          child: const Icon(Icons.clear),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'location_button',
          onPressed: onLocate,
          child: const Icon(Icons.my_location),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'help_button',
          onPressed: onHelp,
          child: const Icon(Icons.help),
        ),
      ],
    );
  }
}
