import 'package:flutter/material.dart';
import 'package:frontend/core/providers/community_provider.dart';
import 'package:frontend/core/providers/disaster_provider.dart';
import 'package:frontend/core/providers/ecology_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/responsive_layout.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/core/providers/rental_provider.dart';
import 'package:frontend/core/providers/scanner_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:frontend/config/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestLocationPermission();
  EnvironmentConfig.initialize(Environment.dev);
  runApp(MyApp());
}

Future<void> _requestLocationPermission() async {
  PermissionStatus status = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.location.request();
  }
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
        ChangeNotifierProvider(create: (context) => EcologyProvider()),
        ChangeNotifierProvider(create: (context) => CommunityProvider()),
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
