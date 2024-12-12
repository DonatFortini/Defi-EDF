import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/ecology_provider.dart';
import 'package:frontend/layout/ecology_content.dart';

class EcologyPage extends StatelessWidget {
  const EcologyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EcologyProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Écologie - Calcul du Coût')),
        body: const EcologyContent(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            // Actions supplémentaires, par exemple afficher des conseils écologiques
          },
          child: const Icon(Icons.info, color: Colors.white),
        ),
      ),
    );
  }
}
