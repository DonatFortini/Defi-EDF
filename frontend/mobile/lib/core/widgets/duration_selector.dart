import 'package:flutter/material.dart';
import 'package:mobile/domain/rental_controller.dart';

class DurationSelector extends StatelessWidget {
  final RentalController controller;
  final String selectedDuration;
  final ValueChanged<String> onDurationChanged;

  static const List<String> durations = [
    '30 min',
    '1 h',
    '2 h',
    '3 h',
    '4 h',
    '5 h',
    '6 h',
    '7 h',
  ];

  static const List<String> quickDurations = ['30 min', '1 h', '2 h', '4 h'];

  const DurationSelector({
    super.key,
    required this.selectedDuration,
    required this.onDurationChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Durée de location",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: selectedDuration,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onDurationChanged(newValue);
            }
          },
          items:
              durations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children:
              quickDurations.map((duration) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: duration != quickDurations.last ? 10 : 0,
                    ),
                    child: ElevatedButton(
                      onPressed: () => onDurationChanged(duration),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedDuration == duration
                                ? Theme.of(context).primaryColor
                                : Colors.grey[300],
                      ),
                      child: Text(duration),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
