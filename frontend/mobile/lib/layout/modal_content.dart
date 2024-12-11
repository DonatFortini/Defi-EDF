import 'package:flutter/material.dart';
import 'package:frontend/screens/rental_page.dart';
import 'package:frontend/widgets/quick_action_card.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            buildQuickActionCard(
              context,
              'Louer une voiture',
              Icons.car_rental,
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RentalPage()),
                );
              },
            ),
            SizedBox(height: 10),
            buildQuickActionCard(
              context,
              'Rendre une voiture',
              Icons.assignment_return,
              Colors.blue,
              () {
                // We don't need to navigate here as bottom nav will handle it
              },
            ),
            SizedBox(height: 10),
            buildQuickActionCard(
              context,
              'Déclarer un accident',
              Icons.car_crash,
              Colors.red,
              () {
                // We don't need to navigate here as bottom nav will handle it
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
