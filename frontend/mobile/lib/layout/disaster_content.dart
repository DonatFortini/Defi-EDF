import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/disaster_provider.dart';
import 'package:frontend/widgets/disaster/gps_button.dart';
import 'package:frontend/widgets/disaster/incident_form.dart';

class DisasterContent extends StatelessWidget {
  const DisasterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DisasterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Déclaration d\'incident'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              GpsButton(),
              SizedBox(height: 20),
              IncidentForm(),
            ],
          ),
        ),
      ),
    );
  }
}
