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
          'Select Rental Dates & Time',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: rentalProvider.startDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (pickedDate != null) {
                    rentalProvider.setStartDate(pickedDate);
                  }
                },
                child: Text(
                  rentalProvider.startDate != null
                      ? '${rentalProvider.startDate!.toLocal()}'.split(' ')[0]
                      : 'Start Date',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    rentalProvider.setStartTime(pickedTime);
                  }
                },
                child: Text(
                  rentalProvider.startTime != null
                      ? rentalProvider.startTime!.format(context)
                      : 'Start Time',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        rentalProvider.endDate ??
                        DateTime.now().add(const Duration(days: 1)),
                    firstDate: rentalProvider.startDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (pickedDate != null) {
                    rentalProvider.setEndDate(pickedDate);
                  }
                },
                child: Text(
                  rentalProvider.endDate != null
                      ? '${rentalProvider.endDate!.toLocal()}'.split(' ')[0]
                      : 'End Date',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    rentalProvider.setEndTime(pickedTime);
                  }
                },
                child: Text(
                  rentalProvider.endTime != null
                      ? rentalProvider.endTime!.format(context)
                      : 'End Time',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
