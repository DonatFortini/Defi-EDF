import 'package:flutter/material.dart';

class WebHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Web-Specific Layout'),
            ElevatedButton(
              onPressed: () {
                // Web-specific action
              },
              child: Text('Web Action'),
            ),
          ],
        ),
      ),
    );
  }
}
