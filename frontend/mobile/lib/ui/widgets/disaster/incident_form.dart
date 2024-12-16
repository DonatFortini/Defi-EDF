import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/image_picker_widget.dart';
import 'package:mobile/ui/widgets/disaster/car_damage_selector.dart';

class IncidentForm extends StatefulWidget {
  const IncidentForm({super.key});

  @override
  _IncidentFormState createState() => _IncidentFormState();
}

class _IncidentFormState extends State<IncidentForm> {
  String? _incidentType;
  String _vehicleDetails = '';
  Image? _selectedImage;

  void _updateIncidentType(String? type) {
    setState(() {
      _incidentType = type;
    });
  }

  void _updateVehicle(String details) {
    setState(() {
      _vehicleDetails = details;
    });
  }

  void _updateImage(Image image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void _submitReport() {
    // Handle the form submission logic here
    print('Incident Type: $_incidentType');
    print('Vehicle Details: $_vehicleDetails');
    print('Selected Image: $_selectedImage');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: _incidentType,
          items:
              ['Accident', 'Panne', 'Autre']
                  .map(
                    (type) => DropdownMenuItem(value: type, child: Text(type)),
                  )
                  .toList(),
          onChanged: _updateIncidentType,
          decoration: const InputDecoration(labelText: 'Type d\'incident'),
        ),
        const SizedBox(height: 20),

        // Car replica with clickable areas
        const CarDamageSelector(),

        const SizedBox(height: 20),

        // Precision field for extra details
        TextFormField(
          onChanged: _updateVehicle,
          decoration: const InputDecoration(
            labelText: 'Détails supplémentaires sur les dommages',
          ),
        ),
        const SizedBox(height: 20),

        ImagePickerWidget(
          updateImageCallback: (image) {
            _updateImage(image! as Image);
          },
        ),

        ElevatedButton(
          onPressed: _submitReport,
          child: const Text('Déclarer l\'incident'),
        ),
      ],
    );
  }
}
