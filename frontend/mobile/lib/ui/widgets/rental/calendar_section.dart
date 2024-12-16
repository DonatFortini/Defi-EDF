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
        ),
        const SizedBox(height: 10),
        DatePickerField(
          label: 'Date de fin',
          value: controller.booking.endDate,
          onChanged: controller.setEndDate,
          minDate: controller.booking.startDate,
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
            selectedDuration:
                controller.booking.interventionDuration ??
                '2 h', // Valeur par défaut si null
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
