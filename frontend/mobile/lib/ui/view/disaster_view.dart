import 'package:flutter/material.dart';
import 'package:mobile/ui/widgets/disaster/incident_form.dart';

class DisasterView extends StatelessWidget {
  const DisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Déclaration d\'incident')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [SizedBox(height: 20), IncidentForm()],
        ),
      ),
    );
  }
}
