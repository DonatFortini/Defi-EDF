import 'package:flutter/material.dart';
import 'package:mobile/data/models/article.dart';
import 'package:mobile/data/models/training.dart';
import 'package:mobile/ui/widgets/community/article.dart';
import 'package:mobile/ui/widgets/community/training_tile.dart';

class CommunityView extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title:
          'Conduite écologique : comment réduire sa consommation de carburant ?',
      content:
          'La conduite écologique est une pratique qui permet de réduire sa consommation de carburant et donc de limiter les émissions de CO2. Pour cela, il est important de respecter quelques règles simples : anticiper les freinages, rouler à une vitesse constante, éviter les accélérations brusques, etc. Découvrez dans cet article nos conseils pour adopter une conduite plus écologique.',
      description: 'Conduite écologique',
    ),
    Article(
      title: 'Les avantages de la voiture électrique',
      content:
          'La voiture électrique est une alternative écologique à la voiture thermique. En effet, elle permet de réduire les émissions de CO2 et de limiter la pollution atmosphérique. De plus, elle est plus silencieuse et moins coûteuse à l\'usage. Découvrez dans cet article les avantages de la voiture électrique et les aides financières dont vous pouvez bénéficier pour son achat.',
      description: 'Voiture électrique',
    ),
    Article(
      title: 'Les gestes simples pour réduire sa consommation d\'énergie',
      content:
          'Réduire sa consommation d\'énergie est un geste simple et efficace pour lutter contre le réchauffement climatique. Pour cela, il est important d\'adopter quelques gestes simples au quotidien : éteindre les lumières en sortant d\'une pièce, débrancher les appareils électriques inutilisés, limiter la consommation d\'eau chaude, etc. Découvrez dans cet article nos conseils pour réduire votre consommation d\'énergie et faire des économies sur vos factures.',
      description: 'Consommation d\'énergie',
    ),
  ];

  final List<Training> trainings = [
    Training(
      title: 'Formation à la transition énergétique',
      description:
          'La transition énergétique est un enjeu majeur pour l\'avenir de notre planète. Pour accompagner les professionnels dans cette démarche, nous proposons une formation complète sur les enjeux de la transition énergétique, les solutions existantes et les bonnes pratiques à adopter. Cette formation s\'adresse aux professionnels du bâtiment, de l\'industrie et de l\'environnement.',
      link: 'https://www.google.com',
    ),
    Training(
      title: 'Formation à la mobilité durable',
      description:
          'La mobilité durable est un enjeu majeur pour réduire les émissions de CO2 et lutter contre le réchauffement climatique. Pour accompagner les professionnels dans cette démarche, nous proposons une formation complète sur les enjeux de la mobilité durable, les solutions existantes et les bonnes pratiques à adopter. Cette formation s\'adresse aux professionnels des transports, de la logistique et de l\'urbanisme.',
      link: 'https://www.google.com',
    ),
    Training(
      title: 'Formation à la gestion des déchets',
      description:
          'La gestion des déchets est un enjeu majeur pour préserver l\'environnement et limiter les impacts sur la santé. Pour accompagner les professionnels dans cette démarche, nous proposons une formation complète sur les enjeux de la gestion des déchets, les solutions existantes et les bonnes pratiques à adopter. Cette formation s\'adresse aux professionnels de l\'environnement, de l\'industrie et de l\'urbanisme.',
      link: 'https://www.google.com',
    ),
  ];

  CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Articles sur la conduite écologique',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleTile(article: articles[index]);
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Formations sur la transition énergétique',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trainings.length,
              itemBuilder: (context, index) {
                return TrainingTile(training: trainings[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
