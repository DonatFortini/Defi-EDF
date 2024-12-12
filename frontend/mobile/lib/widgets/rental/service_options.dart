import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';

class RentalServiceOptions extends StatelessWidget {
  const RentalServiceOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Services',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        CheckboxListTile(
          title: const Text('GPS Navigation'),
          value: rentalProvider.additionalServices.contains('GPS Navigation'),
          onChanged: (bool? value) {
            rentalProvider.toggleAdditionalService('GPS Navigation');
          },
        ),
        CheckboxListTile(
          title: const Text('Child Seat'),
          value: rentalProvider.additionalServices.contains('Child Seat'),
          onChanged: (bool? value) {
            rentalProvider.toggleAdditionalService('Child Seat');
          },
        ),
        CheckboxListTile(
          title: const Text('Additional Driver'),
          value: rentalProvider.additionalServices.contains(
            'Additional Driver',
          ),
          onChanged: (bool? value) {
            rentalProvider.toggleAdditionalService('Additional Driver');
          },
        ),
      ],
    );
  }
}
