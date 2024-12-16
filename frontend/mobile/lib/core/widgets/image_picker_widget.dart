import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // Pour le type MIME
import 'package:mime/mime.dart'; // Pour détecter le type MIME
import 'package:http/http.dart' as http;

class ImagePickerWidget extends StatefulWidget {
  final void Function(File?) updateImageCallback;

  const ImagePickerWidget({super.key, required this.updateImageCallback});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;
  bool _isUploading = false;
  String _uploadStatus = '';
  //TODO : Remplacer par l'URL de votre serveur
  String url = 'http://localhost:3000/upload';

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
          Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed:
                _isUploading
                    ? null
                    : () {
                      if (_selectedImage != null) {
                        uploadImage(_selectedImage!, url);
                      }
                    },
            child:
                _isUploading
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

  void uploadImage(File file, String url) {
    setState(() {
      _isUploading = true;
    });

    final mimeType = lookupMimeType(file.path);
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(
        http.MultipartFile(
          'image',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType.parse(mimeType!),
        ),
      );

    imageUploadRequest.send().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _uploadStatus = 'Image envoyée avec succès';
          _isUploading = false;
        });
      } else {
        setState(() {
          _uploadStatus = 'Erreur lors de l\'envoi de l\'image';
          _isUploading = false;
        });
      }
    });
  }
}
