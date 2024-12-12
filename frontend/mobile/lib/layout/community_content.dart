import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/community_provider.dart';
import 'package:frontend/widgets/community/article.dart';
import 'package:frontend/widgets/community/training_tile.dart';

class CommunityContent extends StatelessWidget {
  const CommunityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<CommunityProvider>(
        builder: (context, communityProvider, child) {
          final articles = communityProvider.articles;
          final trainings = communityProvider.trainings;

          return SingleChildScrollView(
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
          );
        },
      ),
    );
  }
}
