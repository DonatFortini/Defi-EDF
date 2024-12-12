import 'package:flutter/foundation.dart';

class CommunityProvider extends ChangeNotifier {
  // Liste des articles
  final List<Article> _articles = [
    Article(
      title: 'Comment adopter une conduite écologique ?',
      description:
          'Découvrez les gestes simples pour conduire de manière plus écologique.',
      content: 'Contenu complet de l\'article...',
    ),
    Article(
      title: 'Les avantages des véhicules électriques',
      description: 'Comprendre pourquoi passer à un véhicule électrique.',
      content: 'Contenu complet de l\'article...',
    ),
  ];

  // Liste des formations
  final List<Training> _trainings = [
    Training(
      title: 'Formation à la conduite éco-responsable',
      description:
          'Formation sur les meilleures pratiques pour conduire de manière économe.',
      link: 'https://example.com/formation',
    ),
    Training(
      title: 'Transition énergétique dans le secteur du transport',
      description:
          'Formation pour comprendre la transition énergétique dans le domaine des transports.',
      link: 'https://example.com/formation2',
    ),
  ];

  List<Article> get articles => _articles;
  List<Training> get trainings => _trainings;
}

// Classe représentant un article
class Article {
  final String title;
  final String description;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.content,
  });
}

// Classe représentant une formation
class Training {
  final String title;
  final String description;
  final String link;

  Training({
    required this.title,
    required this.description,
    required this.link,
  });
}
