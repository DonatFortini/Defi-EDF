import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/rental_provider.dart';

class RentalCarSelection extends StatelessWidget {
  const RentalCarSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final rentalProvider = Provider.of<RentalProvider>(context);

    final cars = [
      {
        'brand': 'Toyota',
        'model': 'Corolla',
        'range': 600,
        'details': 'Coffre large, Climatisation',
        'isElectric': false,
        'fuelLevel': 80,
        'available': true,
      },
      {
        'brand': 'Honda',
        'model': 'Civic',
        'range': 550,
        'details': 'Coffre moyen, GPS intégré',
        'isElectric': false,
        'fuelLevel': 60,
        'available': true,
      },
      {
        'brand': 'Ford',
        'model': 'Focus',
        'range': 0,
        'details': 'Coffre petit, Bluetooth',
        'isElectric': true,
        'batteryLevel': 50,
        'available': false,
      },
      {
        'brand': 'Volkswagen',
        'model': 'Golf',
        'range': 700,
        'details': 'Coffre large, Sièges chauffants',
        'isElectric': false,
        'fuelLevel': 90,
        'available': true,
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          final isAvailable = car['available'] as bool;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: isAvailable ? Colors.white : Colors.grey[300],
            child: InkWell(
              onTap:
                  isAvailable
                      ? () => rentalProvider.setSelectedCar(
                        '${car['brand']} ${car['model']}',
                      )
                      : null,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          car['brand'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                isAvailable ? Colors.black : Colors.grey[600],
                          ),
                        ),
                        if (car['isElectric'] as bool)
                          Icon(
                            Icons.battery_full,
                            color: isAvailable ? Colors.green : Colors.grey,
                          )
                        else
                          Icon(
                            Icons.local_gas_station,
                            color: isAvailable ? Colors.orange : Colors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      car['model'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: isAvailable ? Colors.black : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Autonomie: ${car['range']} km',
                      style: TextStyle(
                        fontSize: 12,
                        color: isAvailable ? Colors.black : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      car['details'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: isAvailable ? Colors.black : Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (car['isElectric'] as bool)
                          Text(
                            'Batterie: ${car['batteryLevel']}%',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isAvailable ? Colors.black : Colors.grey[600],
                            ),
                          )
                        else
                          Text(
                            'Carburant: ${car['fuelLevel']}%',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isAvailable ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        Text(
                          isAvailable ? 'Disponible' : 'Indisponible',
                          style: TextStyle(
                            fontSize: 12,
                            color: isAvailable ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
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
