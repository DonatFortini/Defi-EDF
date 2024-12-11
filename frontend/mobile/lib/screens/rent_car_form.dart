import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/rent_car_provider.dart';

class RentCarForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rent a Car')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Consumer<RentalProvider>(
          builder: (context, rentalProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Rental Dates',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                rentalProvider.startDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (picked != null) {
                            rentalProvider.setStartDate(picked);
                          }
                        },
                        child: Text(
                          rentalProvider.startDate != null
                              ? '${rentalProvider.startDate!.toLocal()}'.split(
                                ' ',
                              )[0]
                              : 'Select Start Date',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                rentalProvider.endDate ??
                                DateTime.now().add(Duration(days: 1)),
                            firstDate:
                                rentalProvider.startDate ?? DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (picked != null) {
                            rentalProvider.setEndDate(picked);
                          }
                        },
                        child: Text(
                          rentalProvider.endDate != null
                              ? '${rentalProvider.endDate!.toLocal()}'.split(
                                ' ',
                              )[0]
                              : 'Select End Date',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Select a Car',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  isExpanded: true,
                  value: rentalProvider.selectedCar,
                  hint: Text('Choose a car'),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      rentalProvider.setSelectedCar(newValue);
                    }
                  },
                  items:
                      <String>[
                        'Toyota Corolla',
                        'Honda Civic',
                        'Ford Focus',
                        'Volkswagen Golf',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Additional Services',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                CheckboxListTile(
                  title: Text('GPS Navigation'),
                  value: rentalProvider.additionalServices.contains(
                    'GPS Navigation',
                  ),
                  onChanged: (bool? value) {
                    rentalProvider.toggleAdditionalService('GPS Navigation');
                  },
                ),
                CheckboxListTile(
                  title: Text('Child Seat'),
                  value: rentalProvider.additionalServices.contains(
                    'Child Seat',
                  ),
                  onChanged: (bool? value) {
                    rentalProvider.toggleAdditionalService('Child Seat');
                  },
                ),
                CheckboxListTile(
                  title: Text('Additional Driver'),
                  value: rentalProvider.additionalServices.contains(
                    'Additional Driver',
                  ),
                  onChanged: (bool? value) {
                    rentalProvider.toggleAdditionalService('Additional Driver');
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement rental submission logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Rental submitted successfully!')),
                    );
                    rentalProvider.resetForm();
                    Navigator.pop(context);
                  },
                  child: Text('Submit Rental'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
