import 'package:flutter/material.dart';
import 'package:frontend/screens/disaster_page.dart';
import 'package:frontend/screens/faulty_comp_page.dart';
import 'package:frontend/screens/rental_page.dart';
import 'package:frontend/screens/scanner_page.dart';
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
              'a une voiture',
              Icons.assignment_return,
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScannerPage(
                            isMileageScan: false,
                          )),
                );
              },
            ),
            SizedBox(height: 10),
            buildQuickActionCard(
              context,
              'Déclarer un accident',
              Icons.car_crash,
              Colors.red,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisasterPage()),
                );
              },
            ),
            SizedBox(height: 10),
            buildQuickActionCard(
              context,
              'Pièces défectueuses',
              Icons.broken_image_rounded,
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FaultyCompPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
