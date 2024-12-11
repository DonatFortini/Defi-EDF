import 'package:flutter/material.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mobile App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mobile-Specific Layout'),
            ElevatedButton(
              onPressed: () {
                // Mobile-specific action
              },
              child: Text('Mobile Action'),
            ),
          ],
        ),
      ),
    );
  }
}
