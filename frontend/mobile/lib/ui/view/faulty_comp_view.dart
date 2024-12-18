import 'package:flutter/material.dart';
import 'dart:io';
import 'package:mobile/core/widgets/image_picker_widget.dart';

class FaultyCompView extends StatefulWidget {
  const FaultyCompView({super.key});

  @override
  State<FaultyCompView> createState() => _FaultyCompViewState();
}

class _FaultyCompViewState extends State<FaultyCompView> {
  final _formKey = GlobalKey<FormState>();
  String _componentName = '';
  String _description = '';
  File? _selectedImage;

  final options = [
    'Freins',
    'Moteur',
    'Essuie-glace',
    'Pare-brise',
    'Pneu',
    'Autres',
  ];

  void _updateImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      // TODO: Implement your submit logic here
      print('Submitting form with:');
      print('Component Name: $_componentName');
      print('Description: $_description');
      print('Image Path: ${_selectedImage?.path}');
    } else if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler une pièce défectueuse')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Component Name Field
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Nom de la pièce',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.build),
                  ),
                  items:
                      options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner le nom de la pièce';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _componentName = value ?? '';
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Description Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description du problème',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez décrire le problème';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value ?? '';
                  },
                ),
                const SizedBox(height: 20),

                // Image Picker
                ImagePickerWidget(updateImageCallback: _updateImage),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitForm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Soumettre',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
