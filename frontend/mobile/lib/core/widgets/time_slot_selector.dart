import 'package:flutter/material.dart';
import 'package:mobile/domain/rental_controller.dart';

class TimeSlotSelector extends StatelessWidget {
  final String? selectedSlot;
  final ValueChanged<String> onSlotChanged;
  final RentalController controller;

  const TimeSlotSelector({
    super.key,
    required this.selectedSlot,
    required this.onSlotChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Créneau horaire",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => onSlotChanged('Matin'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedSlot == 'Matin'
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
                child: const Text('Matin'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => onSlotChanged('Apres-midi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedSlot == 'Apres-midi'
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
                child: const Text('Apres-midi'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => onSlotChanged('Journée'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedSlot == 'Journée'
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
                child: const Text('Journée'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
