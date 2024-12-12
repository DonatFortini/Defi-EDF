import 'package:flutter/material.dart';
import 'package:frontend/core/providers/disaster_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/responsive_layout.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/core/providers/rental_provider.dart';
import 'package:frontend/core/providers/scanner_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RentalProvider()),
        ChangeNotifierProvider(create: (context) => ScannerProvider()),
        ChangeNotifierProvider(create: (context) => DisasterProvider()),
      ],
      child: MaterialApp(
        title: 'Bienvenue _Placeholder_',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ResponsiveLayout(mobile: MobileHomePage()),
      ),
    );
  }
}
