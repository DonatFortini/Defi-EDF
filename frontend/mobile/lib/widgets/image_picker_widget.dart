import 'package:flutter/material.dart';
import 'package:frontend/config/environment.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // Pour le type MIME
import 'package:mime/mime.dart'; // Pour détecter le type MIME
import 'package:http/http.dart' as http;

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
  bool _isUploading = false;
  String _uploadStatus = '';

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _uploadStatus = ''; // Réinitialise le statut de l'envoi
      });
      widget.updateImageCallback(_selectedImage);
    }
  }

  Future<void> uploadPlate(File imageFile) async {
    final url = EnvironmentConfig.sendPlateRoute(); // Récupération de l'URL

    final mimeType =
        lookupMimeType(imageFile.path) ?? 'application/octet-stream';
    final mimeSplit = mimeType.split('/');

    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // Nom du paramètre attendu par le backend
        imageFile.path,
        contentType: MediaType(mimeSplit[0], mimeSplit[1]),
      ),
    );

    try {
      setState(() {
        _isUploading = true;
        _uploadStatus = 'Envoi en cours...';
      });

      final response = await request.send();

      setState(() {
        _isUploading = false;
        if (response.statusCode == 200) {
          _uploadStatus = 'Upload réussi !';
        } else {
          _uploadStatus = 'Erreur lors de l\'upload: ${response.statusCode}';
        }
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadStatus = 'Erreur: $e';
      });
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
          )
        else ...[
          Image.file(
            _selectedImage!,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _isUploading
                ? null
                : () {
                    if (_selectedImage != null) {
                      uploadPlate(_selectedImage!);
                    }
                  },
            child: _isUploading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Envoyer la photo'),
          ),
          const SizedBox(height: 10),
          Text(
            _uploadStatus,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
