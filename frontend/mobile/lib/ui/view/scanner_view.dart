import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScannerView extends StatefulWidget {
  final bool isMileageScan;

  const ScannerView({super.key, required this.isMileageScan});

  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  bool isLoading = false;
  String? errorMessage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        if (widget.isMileageScan) {
          await _scanMileage(File(pickedFile.path));
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else {
          await _scanPlate(File(pickedFile.path));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScannerView(isMileageScan: true),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to take picture: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _scanMileage(File file) async {
    // Implement your mileage scan logic here
  }

  Future<void> _scanPlate(File file) async {
    // Implement your plate scan logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isMileageScan ? 'Mileage Scanner' : 'Plate Scanner'),
      ),
      body: Center(
        child:
            isLoading
                ? const CircularProgressIndicator()
                : errorMessage != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.blue,
                              ),
                              onPressed: _takePicture,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Text('ou'),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Input Field',
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Visibility(
                      visible: errorMessage != null,
                      child: Text(
                        errorMessage ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
