import 'package:flutter/material.dart';
import 'package:mobile/data/models/rental_car.dart';
import 'package:mobile/domain/rental_controller.dart';

class CarSection extends StatelessWidget {
  final RentalController controller;

  const CarSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Véhicule', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        _buildSeatSelector(context),
        const SizedBox(height: 16),
        _buildCarList(),
      ],
    );
  }

  Widget _buildSeatSelector(BuildContext context) {
    return Row(
      children: [
        const Text('Nombre de places: '),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed:
                    controller.booking.selectedSeats > 1
                        ? () => controller.setSelectedSeats(
                          controller.booking.selectedSeats - 1,
                        )
                        : null,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 40),
                alignment: Alignment.center,
                child: Text(
                  '${controller.booking.selectedSeats}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed:
                    controller.booking.selectedSeats < 7
                        ? () => controller.setSelectedSeats(
                          controller.booking.selectedSeats + 1,
                        )
                        : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.availableCars.length,
      itemBuilder: (context, index) {
        final car = controller.availableCars[index];
        final isSelected =
            controller.booking.selectedCar?.fullName == car.fullName;

        return Card(
          elevation: isSelected ? 4 : 1,
          margin: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => controller.setSelectedCar(car.fullName),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${car.brand} ${car.model}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildCarFeatures(car),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarFeatures(RentalCar car) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildFeatureItem(
          icon: Icons.airline_seat_recline_normal,
          text: '${car.seats} places',
        ),
        _buildFeatureItem(icon: Icons.route, text: '${car.range} km'),
        if (car.isElectric) ...[
          _buildFeatureItem(
            icon: Icons.battery_charging_full,
            text: '${car.batteryLevel}%',
            color: Colors.green,
          ),
        ] else ...[
          _buildFeatureItem(
            icon: Icons.local_gas_station,
            text: '${car.fuelLevel}%',
            color: Colors.orange,
          ),
        ],
        if (car.details.isNotEmpty)
          _buildFeatureItem(icon: Icons.info_outline, text: car.details),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
    Color? color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
