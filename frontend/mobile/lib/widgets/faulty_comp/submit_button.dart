import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/faulty_comp_provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<FaultyCompProvider>().submitReport();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rapport envoyé avec succès')),
        );
      },
      child: const Text('Soumettre'),
    );
  }
}
