import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';

class RentalCalendarPicker extends StatelessWidget {
  const RentalCalendarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Contrôleurs avec les valeurs initiales du provider
    final startDateController = TextEditingController(
      text: rentalProvider.startDate != null
          ? dateFormat.format(rentalProvider.startDate!)
          : '',
    );
    final endDateController = TextEditingController(
      text: rentalProvider.endDate != null
          ? dateFormat.format(rentalProvider.endDate!)
          : '',
    );

    // Fonction pour sélectionner la date de début
    Future<void> _selectStartDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: rentalProvider.startDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (picked != null) {
        startDateController.text = dateFormat.format(picked);
        rentalProvider.setStartDate(picked);
      }
    }

    // Fonction pour sélectionner la date de fin
    Future<void> _selectEndDate() async {
      if (rentalProvider.startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Veuillez d\'abord sélectionner une date de début')),
        );
        return;
      }

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: rentalProvider.endDate ?? rentalProvider.startDate!,
        firstDate: rentalProvider.startDate!,
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (picked != null) {
        endDateController.text = dateFormat.format(picked);
        rentalProvider.setEndDate(picked);
      }
    }

    // Vérifie si les dates sont identiques
    bool isSameDay = rentalProvider.startDate != null &&
        rentalProvider.endDate != null &&
        DateUtils.isSameDay(rentalProvider.startDate!, rentalProvider.endDate!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reservation d'un vehicule",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "Dates de location",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: startDateController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Date de début de location',
            hintText: 'JJ/MM/AAAA',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _selectStartDate,
            ),
          ),
          onTap: _selectStartDate,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: endDateController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Date de fin de location',
            hintText: 'JJ/MM/AAAA',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _selectEndDate,
            ),
          ),
          onTap: _selectEndDate,
        ),
        if (isSameDay) ...[
          const SizedBox(height: 10),
          const Text(
            "Créneau horaire",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => rentalProvider.setTimeSlot('Matin'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rentalProvider.timeSlot == 'Matin'
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                  child: const Text('Matin'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => rentalProvider.setTimeSlot('Apres-midi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rentalProvider.timeSlot == 'Apres-midi'
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                  child: const Text('Apres-midi'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => rentalProvider.setTimeSlot('Journée'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rentalProvider.timeSlot == 'Journée'
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                  child: const Text('Journée'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Durée de location",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: rentalProvider.interventionDuration ?? '2 h',
            onChanged: (String? newValue) {
              rentalProvider.setInterventionDuration(newValue!);
            },
            items: <String>[
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
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      rentalProvider.setInterventionDuration('30 min'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        rentalProvider.interventionDuration == '30 min'
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                  ),
                  child: const Text('30 min'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      rentalProvider.setInterventionDuration('1 h'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        rentalProvider.interventionDuration == '1 h'
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                  ),
                  child: const Text('1 h'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      rentalProvider.setInterventionDuration('2 h'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        rentalProvider.interventionDuration == '2 h'
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                  ),
                  child: const Text('2 h'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      rentalProvider.setInterventionDuration('4 h'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        rentalProvider.interventionDuration == '4 h'
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                  ),
                  child: const Text('4 h'),
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}
