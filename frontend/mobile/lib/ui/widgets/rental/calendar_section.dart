import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/widgets/date_picker_field.dart';
import 'package:mobile/core/widgets/duration_selector.dart';
import 'package:mobile/core/widgets/time_slot_selector.dart';
import 'package:mobile/domain/rental_controller.dart';

class CalendarSection extends StatelessWidget {
  final RentalController controller;
  final dateFormat = DateFormat('dd/MM/yyyy');

  CalendarSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    print('CalendarSection - build');
    print('Start date: ${controller.booking.startDate}');
    print('End date: ${controller.booking.endDate}');

    final DateTime defaultMinDate = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Réservation d'un véhicule",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        DatePickerField(
          label: 'Date de début',
          value: controller.booking.startDate,
          onChanged: controller.setStartDate,
          minDate: defaultMinDate, // Date minimale = aujourd'hui
        ),
        const SizedBox(height: 10),
        DatePickerField(
          label: 'Date de fin',
          value: controller.booking.endDate,
          onChanged: controller.setEndDate,
          // Si pas de date de début, utiliser aujourd'hui comme minimum
          minDate: controller.booking.startDate ?? defaultMinDate,
        ),
        if (_isSameDay(
          controller.booking.startDate,
          controller.booking.endDate,
        )) ...[
          const SizedBox(height: 10),
          TimeSlotSelector(
            controller: controller,
            selectedSlot: controller.booking.timeSlot,
            onSlotChanged: controller.setTimeSlot,
          ),
          const SizedBox(height: 10),
          DurationSelector(
            controller: controller,
            selectedDuration: controller.booking.interventionDuration ?? '2 h',
            onDurationChanged: controller.setInterventionDuration,
          ),
        ],
      ],
    );
  }

  bool _isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return DateUtils.isSameDay(date1, date2);
  }
}
