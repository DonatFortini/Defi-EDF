import 'package:flutter/material.dart';
import 'package:mobile/data/models/training.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingTile extends StatelessWidget {
  final Training training;

  const TrainingTile({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(training.title),
        subtitle: Text(training.description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          _openTrainingLink(context);
        },
      ),
    );
  }

  void _openTrainingLink(BuildContext context) async {
    final url = training.link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir la formation')),
      );
    }
  }
}
