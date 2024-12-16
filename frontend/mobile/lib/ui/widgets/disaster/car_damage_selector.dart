import 'package:flutter/material.dart';

class CarDamageSelector extends StatefulWidget {
  const CarDamageSelector({super.key});

  @override
  CarDamageSelectorState createState() => CarDamageSelectorState();
}

class CarDamageSelectorState extends State<CarDamageSelector> {
  String? selectedArea;
  final GlobalKey _imageKey = GlobalKey();
  Size? imageSize;

  // Zones relatives ajustées pour l'image
  final Map<String, Rect> carParts = {
    'Pare-chocs avant': const Rect.fromLTRB(0.0, 0.4, 0.2, 0.6),
    'Pare-brise': const Rect.fromLTRB(0.3, 0.2, 0.5, 0.4),
    'Roue(s) avant': const Rect.fromLTRB(0.15, 0.65, 0.3, 0.8),
    'Portière avant': const Rect.fromLTRB(0.3, 0.45, 0.6, 0.65),
    'Portière arrière': const Rect.fromLTRB(0.6, 0.45, 0.9, 0.65),
    'Roue(s) arrière': const Rect.fromLTRB(0.7, 0.65, 0.85, 0.8),
    'Coffre': const Rect.fromLTRB(0.85, 0.35, 1.05, 0.55),
  };

  void _updateImageSize() {
    final RenderBox? renderBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        imageSize = renderBox.size;
      });
    }
  }

  Rect _calculateAbsoluteRect(Rect relativeRect, Size size) {
    return Rect.fromLTRB(
      relativeRect.left * size.width,
      relativeRect.top * size.height,
      relativeRect.right * size.width,
      relativeRect.bottom * size.height,
    );
  }

  void _handleTapDown(TapDownDetails details) {
    if (imageSize == null) return;

    final RenderBox box =
        _imageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    for (var entry in carParts.entries) {
      final absoluteRect = _calculateAbsoluteRect(entry.value, imageSize!);
      if (absoluteRect.contains(localPosition)) {
        setState(() {
          selectedArea = entry.key;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTapDown: _handleTapDown,
              child: Container(
                key: _imageKey,
                width: constraints.maxWidth,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/car_replica.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child:
                    imageSize != null
                        ? CustomPaint(
                          painter: HighlightCarPartPainter(
                            selectedArea != null
                                ? _calculateAbsoluteRect(
                                  carParts[selectedArea]!,
                                  imageSize!,
                                )
                                : null,
                          ),
                        )
                        : null,
              ),
            );
          },
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateImageSize();
    });
  }
}

class HighlightCarPartPainter extends CustomPainter {
  final Rect? rect;

  HighlightCarPartPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    if (rect == null) return;

    final paint =
        Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.fill;

    canvas.drawRect(rect!, paint);

    final borderPaint =
        Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawRect(rect!, borderPaint);
  }

  @override
  bool shouldRepaint(HighlightCarPartPainter oldDelegate) =>
      rect != oldDelegate.rect;
}
