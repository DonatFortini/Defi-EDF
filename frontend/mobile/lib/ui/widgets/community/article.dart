import 'package:flutter/material.dart';
import 'package:mobile/data/models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(article.title),
        subtitle: Text(article.description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          _showArticleDetail(context);
        },
      ),
    );
  }

  void _showArticleDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(article.title),
          content: Text(article.content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
