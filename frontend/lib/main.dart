import 'package:flutter/material.dart';
import 'core/responsive_layout.dart';
import 'screens/mobile_home.dart';
import 'screens/web_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cross-Platform App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResponsiveLayout(mobile: MobileHomePage(), web: WebHomePage()),
    );
  }
}
