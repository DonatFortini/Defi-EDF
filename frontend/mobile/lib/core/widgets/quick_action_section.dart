import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/quick_action_card.dart';

class QuickActionSection extends StatelessWidget {
  final List<CardProps> quickActions;

  const QuickActionSection({super.key, required this.quickActions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          quickActions.map((cardProps) {
            return Column(
              children: [
                QuickActionCard(
                  cardProps: cardProps,
                  onTap: () {
                    Navigator.pushNamed(context, cardProps.navigatorPath);
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
    );
  }
}
