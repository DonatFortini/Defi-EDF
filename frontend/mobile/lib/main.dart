import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/responsive_layout.dart';
import 'screens/mobile_home.dart';
import 'core/providers/rent_car_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RentalProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fleet Car Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResponsiveLayout(mobile: MobileHomePage()),
    );
  }
}
