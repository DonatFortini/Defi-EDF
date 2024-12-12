import 'package:flutter/material.dart';

class CarDamageSelector extends StatefulWidget {
  const CarDamageSelector({super.key});

  @override
  _CarDamageSelectorState createState() => _CarDamageSelectorState();
}

class _CarDamageSelectorState extends State<CarDamageSelector> {
  // Variable to store selected damaged area
  String? selectedArea;
  TextEditingController damageDetailsController = TextEditingController();

  final Map<String, Rect> carParts = {
    'Front Bumper': Rect.fromLTWH(0.05, 0.3, 0.2, 0.1),
    'Left Door': Rect.fromLTWH(0.25, 0.3, 0.4, 0.4),
    'Rear Bumper': Rect.fromLTWH(0.7, 0.3, 0.2, 0.1),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapUp: (details) {
            final position = details.localPosition;
            carParts.forEach((partName, area) {
              if (area.contains(position)) {
                setState(() {
                  selectedArea = partName;
                });
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/car_replica.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: selectedArea != null
                ? CustomPaint(
                    painter: HighlightCarPartPainter(carParts[selectedArea]!),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
        if (selectedArea != null)
          Text(
            'Partie endommagée: $selectedArea',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class HighlightCarPartPainter extends CustomPainter {
  final Rect rect;
  HighlightCarPartPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withAlpha(25)
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
