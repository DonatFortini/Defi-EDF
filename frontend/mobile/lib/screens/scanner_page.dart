import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:frontend/core/providers/scanner_provider.dart';

class ScannerPage extends StatelessWidget {
  final bool isMileageScan;

  const ScannerPage({super.key, required this.isMileageScan});

  Future<void> _takePicture(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        final provider = context.read<ScannerProvider>();

        if (isMileageScan) {
          await provider.scanMileage(File(pickedFile.path));
        } else {
          await provider.scanPlate(File(pickedFile.path));
        }

        if (provider.state == ScannerState.success) {
          if (!isMileageScan) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScannerPage(isMileageScan: true),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('All scans completed successfully!')),
            );
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isMileageScan ? 'Mileage Scanner' : 'Plate Scanner'),
      ),
      body: Consumer<ScannerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: provider.clearState,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () => _takePicture(context),
              child: const Text('Start Scan'),
            ),
          );
        },
      ),
    );
  }
}
