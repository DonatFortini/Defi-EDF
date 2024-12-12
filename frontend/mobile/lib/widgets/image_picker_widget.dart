import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final void Function(File?) updateImageCallback;

  const ImagePickerWidget({
    super.key,
    required this.updateImageCallback,
  });

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      widget.updateImageCallback(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(context),
          child: const Text('Joindre une photo'),
        ),
        const SizedBox(height: 10),
        if (_selectedImage == null)
          const Text(
            'Aucune image sélectionnée',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
