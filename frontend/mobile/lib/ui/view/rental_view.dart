import 'package:flutter/material.dart';
import 'package:mobile/domain/rental_controller.dart';
import 'package:mobile/ui/widgets/rental/calendar_section.dart';
import 'package:mobile/ui/widgets/rental/location_section.dart';

class RentalView extends StatelessWidget {
  const RentalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Louer une voiture')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarSection(controller: RentalController()),
              const SizedBox(height: 20),
              LocationSection(),
              const SizedBox(height: 20),
              /* CarSection(),
              const SizedBox(height: 20),
              ServicesSection(),
              const SizedBox(height: 20),
              SubmitButton(), */
            ],
          ),
        ),
      ),
    );
  }
}
