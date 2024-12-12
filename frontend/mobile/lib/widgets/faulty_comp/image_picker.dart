import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/faulty_comp_provider.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource
            .camera); // Modifier pour `ImageSource.gallery` si besoin
    if (image != null) {
      context.read<FaultyCompProvider>().updateImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FaultyCompProvider>();
    final image = provider.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(context),
          child: const Text('Joindre une photo'),
        ),
        const SizedBox(height: 10),
        if (image == null)
          const Text(
            'Aucune image sélectionnée',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
