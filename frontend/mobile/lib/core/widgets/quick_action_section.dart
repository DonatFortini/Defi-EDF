import 'package:flutter/material.dart';

class CardProp {
  final String name;
  final Color color;
  final IconData icon;
  final String navPath;

  CardProp({
    required this.name,
    required this.color,
    required this.icon,
    required this.navPath,
  });
}

class QuickActionSection extends StatelessWidget {
  final List<CardProp> actions;

  const QuickActionSection({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        ...actions.map((action) {
          return buildQuickActionCard(
            context,
            action.name,
            action.icon,
            action.color,
            () {
              Navigator.of(context).pushNamed(action.navPath);
            },
          );
        }),
      ],
    );
  }
}

Widget buildQuickActionCard(
  BuildContext context,
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return Card(
    elevation: 4,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(width: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}
