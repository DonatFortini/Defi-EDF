import 'package:flutter/material.dart';

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
