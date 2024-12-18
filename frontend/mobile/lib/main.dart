import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile/domain/rental_controller.dart';
import 'package:mobile/ui/view/community_view.dart';
import 'package:mobile/ui/view/disaster_view.dart';
import 'package:mobile/ui/view/home_view.dart';
import 'package:mobile/ui/view/profile_view.dart';
import 'package:mobile/ui/utils/modal_actions.dart';
import 'package:mobile/ui/view/rental_view.dart';
import 'package:mobile/ui/view/scanner_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr', 'FR')],
      routes: {
        '/': (context) => MainScreen(),
        '/rental': (context) => RentalView(controller: RentalController()),
        '/ecology': (context) => Container(),
        '/disaster': (context) => DisasterView(),
        '/scanner': (context) => ScannerView(isMileageScan: false),
        '/community': (context) => CommunityView(),
        '/profile': (context) => ProfileView(),
      },
      initialRoute: '/',
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Liste des widgets principaux correspondant aux items de la bottom nav
  static final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Container(),
    Container(),
    CommunityView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ModalActions(context).buildQuickActions();
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Écologie'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communauté',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
