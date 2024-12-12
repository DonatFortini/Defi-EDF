import 'package:flutter/material.dart';

class ScannerContent extends StatelessWidget {
  final VoidCallback onCameraTap;
  final TextEditingController inputController;

  const ScannerContent({
    super.key,
    required this.onCameraTap,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What to Scan', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Partial border corners
                _buildCorner(
                  top: 0,
                  left: 0,
                  borderTop: BorderSide(color: Colors.blue, width: 4),
                  borderLeft: BorderSide(color: Colors.blue, width: 4),
                ),
                _buildCorner(
                  top: 0,
                  right: 0,
                  borderTop: BorderSide(color: Colors.blue, width: 4),
                  borderRight: BorderSide(color: Colors.blue, width: 4),
                ),
                _buildCorner(
                  bottom: 0,
                  left: 0,
                  borderBottom: BorderSide(color: Colors.blue, width: 4),
                  borderLeft: BorderSide(color: Colors.blue, width: 4),
                ),
                _buildCorner(
                  bottom: 0,
                  right: 0,
                  borderBottom: BorderSide(color: Colors.blue, width: 4),
                  borderRight: BorderSide(color: Colors.blue, width: 4),
                ),
                // Camera icon
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.blue,
                  ),
                  onPressed: onCameraTap,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Ou', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: inputController,
          decoration: const InputDecoration(
            hintText: 'Manual input if scan fails',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    BorderSide? borderTop,
    BorderSide? borderBottom,
    BorderSide? borderLeft,
    BorderSide? borderRight,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: borderTop ?? BorderSide.none,
            bottom: borderBottom ?? BorderSide.none,
            left: borderLeft ?? BorderSide.none,
            right: borderRight ?? BorderSide.none,
          ),
        ),
      ),
    );
  }
}
