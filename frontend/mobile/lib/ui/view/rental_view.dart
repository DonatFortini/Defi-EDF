import 'package:flutter/material.dart';
import 'package:mobile/domain/rental_controller.dart';
import 'package:mobile/ui/widgets/rental/calendar_section.dart';
import 'package:mobile/ui/widgets/rental/car_section.dart';
import 'package:mobile/ui/widgets/rental/location_section.dart';

class RentalView extends StatelessWidget {
  final RentalController controller;
  const RentalView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Utiliser AnimatedBuilder pour reconstruire l'UI quand le controller change
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Louer une voiture')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarSection(controller: controller),
                  const SizedBox(height: 20),
                  LocationSection(),
                  const SizedBox(height: 20),
                  CarSection(controller: controller),
                  const SizedBox(height: 20),
                  /* ServicesSection(),
                  const SizedBox(height: 20),
                  SubmitButton(), */
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
