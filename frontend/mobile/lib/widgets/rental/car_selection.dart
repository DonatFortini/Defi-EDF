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
        'seats': 5,
        'details': 'Coffre large, Climatisation',
        'isElectric': false,
        'fuelLevel': 80,
        'available': true,
      },
      {
        'brand': 'Honda',
        'model': 'Civic',
        'range': 550,
        'seats': 5,
        'details': 'Coffre moyen, GPS intégré',
        'isElectric': false,
        'fuelLevel': 60,
        'available': true,
      },
      {
        'brand': 'Ford',
        'model': 'Focus',
        'range': 0,
        'seats': 5,
        'details': 'Coffre petit, Bluetooth',
        'isElectric': true,
        'batteryLevel': 50,
        'available': false,
      },
      {
        'brand': 'Volkswagen',
        'model': 'Golf',
        'range': 700,
        'seats': 5,
        'details': 'Coffre large, Sièges chauffants',
        'isElectric': false,
        'fuelLevel': 90,
        'available': true,
      },
    ];

    // Trouver le nombre maximum de places parmi toutes les voitures
    final maxSeats = cars.fold<int>(
        0, (max, car) => car['seats'] as int > max ? car['seats'] as int : max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Nombre de passagers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: rentalProvider.selectedSeats == 1
                              ? null
                              : () => rentalProvider.setSelectedSeats(
                                  (rentalProvider.selectedSeats ?? 2) - 1),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(minWidth: 40),
                          alignment: Alignment.center,
                          child: Text(
                            '${rentalProvider.selectedSeats ?? 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed:
                              (rentalProvider.selectedSeats ?? 1) >= maxSeats
                                  ? null
                                  : () => rentalProvider.setSelectedSeats(
                                      (rentalProvider.selectedSeats ?? 1) + 1),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.event_seat,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              final isAvailable = car['available'] as bool;
              final hasEnoughSeats =
                  (car['seats'] as int) >= (rentalProvider.selectedSeats ?? 1);

              return Opacity(
                opacity: hasEnoughSeats && isAvailable ? 1.0 : 0.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: isAvailable ? Colors.white : Colors.grey[300],
                  child: InkWell(
                    onTap: (isAvailable && hasEnoughSeats)
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
                                  color: isAvailable
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              ),
                              if (car['isElectric'] as bool)
                                Icon(
                                  Icons.battery_full,
                                  color:
                                      isAvailable ? Colors.green : Colors.grey,
                                )
                              else
                                Icon(
                                  Icons.local_gas_station,
                                  color:
                                      isAvailable ? Colors.orange : Colors.grey,
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            car['model'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isAvailable ? Colors.black : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.event_seat,
                                size: 16,
                                color: isAvailable
                                    ? Colors.black
                                    : Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Jusqu\'à ${car['seats']} places',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isAvailable
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Autonomie: ${car['range']} km',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isAvailable ? Colors.black : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            car['details'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isAvailable ? Colors.black : Colors.grey[600],
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
                                    color: isAvailable
                                        ? Colors.black
                                        : Colors.grey[600],
                                  ),
                                )
                              else
                                Text(
                                  'Carburant: ${car['fuelLevel']}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isAvailable
                                        ? Colors.black
                                        : Colors.grey[600],
                                  ),
                                ),
                              Text(
                                isAvailable ? 'Disponible' : 'Indisponible',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isAvailable ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
