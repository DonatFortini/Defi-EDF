import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';

class RentalCarSelection extends StatelessWidget {
  const RentalCarSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);

    final cars = [
      {'name': 'Toyota Corolla', 'available': true},
      {'name': 'Honda Civic', 'available': true},
      {'name': 'Ford Focus', 'available': false},
      {'name': 'Volkswagen Golf', 'available': true},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          final isAvailable = car['available'] as bool;

          return Card(
            color: isAvailable ? Colors.white : Colors.grey[300],
            child: InkWell(
              onTap:
                  isAvailable
                      ? () =>
                          rentalProvider.setSelectedCar(car['name'] as String)
                      : null,
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 40,
                      color: isAvailable ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      car['name'] as String,
                      style: TextStyle(
                        color: isAvailable ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
