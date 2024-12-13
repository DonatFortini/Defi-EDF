import 'package:flutter/material.dart';
import 'package:frontend/widgets/rental/roadmap.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';
import 'package:frontend/widgets/rental/calendar_picker.dart';
import 'package:frontend/widgets/rental/car_selection.dart';
import 'package:frontend/widgets/rental/service_options.dart';

class RentalContent extends StatelessWidget {
  const RentalContent({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Louer une voiture')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RentalCalendarPicker(),
            const SizedBox(height: 20),
            const LocationMapPicker(),
            const SizedBox(height: 20),
            Text(
              'Véhicule disponible',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            const RentalCarSelection(),
            const SizedBox(height: 20),
            const RentalServiceOptions(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement rental submission logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rental submitted successfully!'),
                  ),
                );
                rentalProvider.resetForm();
                Navigator.pop(context);
              },
              child: const Text('Submit Rental'),
            ),
          ],
        ),
      ),
    );
  }
}
