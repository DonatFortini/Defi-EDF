import 'package:flutter/material.dart';

class CardProps {
  final String textVal;
  final Color color;
  final IconData oIcon;
  final String navigatorPath;

  CardProps({
    required this.textVal,
    required this.color,
    required this.oIcon,
    required this.navigatorPath,
  });
}

class QuickActionCard extends StatelessWidget {
  final CardProps cardProps;
  final VoidCallback onTap;

  const QuickActionCard({
    Key? key,
    required this.cardProps,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(cardProps.oIcon, size: 40, color: cardProps.color),
              SizedBox(width: 16),
              Text(
                cardProps.textVal,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
