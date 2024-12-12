import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';

class RentalCalendarPicker extends StatelessWidget {
  const RentalCalendarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reservation d'un vehicule",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setTimeSlot('Matin');
                },
                child: const Text('Matin'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setTimeSlot('Apres-midi');
                },
                child: const Text('Apres-midi'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setTimeSlot('Journée');
                },
                child: const Text('Journée'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Date d'intervention",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Entrez la date',
            hintText: 'JJ/MM/AAAA',
          ),
          keyboardType: TextInputType.datetime,
          onChanged: (value) {
            rentalProvider.setInterventionDate(value);
          },
        ),
        const SizedBox(height: 10),
        Text(
          "Durée d'intervention estimée",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: DropdownButton<String>(
            value: rentalProvider.interventionDuration ?? '2 h',
            onChanged: (String? newValue) {
              rentalProvider.setInterventionDuration(newValue!);
            },
            items:
                <String>[
                  '30 min',
                  '1 h',
                  '2 h',
                  '3 h',
                  '4 h',
                  '5 h',
                  '6 h',
                  '7 h',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setInterventionDuration('30 min');
                },
                child: const Text('30 min'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setInterventionDuration('1 h');
                },
                child: const Text('1 h'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setInterventionDuration('2 h');
                },
                child: const Text('2 h'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rentalProvider.setInterventionDuration('4 h');
                },
                child: const Text('4 h'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
