import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:frontend/core/providers/scanner_provider.dart';
import 'package:frontend/layout/scanner_content.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final TextEditingController _inputController = TextEditingController();

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Launch camera and pick an image
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        // Use Provider to handle image upload
        await context
            .read<ScannerProvider>()
            .takePicture(File(pickedFile.path));
      }
    } catch (e) {
      // Show error using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Listen for scan results and update input field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScannerProvider>().addListener(() {
        final provider = context.read<ScannerProvider>();
        if (provider.scanResult != null) {
          _inputController.text = provider.scanResult!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ScannerProvider>(
          builder: (context, scannerProvider, child) {
            // Afficher un indicateur de chargement si l'image est en cours de traitement
            if (scannerProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Afficher un message d'erreur si l'upload échoue
            if (scannerProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scannerProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () => scannerProvider.clearScan(),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            }

            // Interface utilisateur normale
            return ScannerContent(
              onCameraTap: _takePicture,
              inputController: _inputController,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
