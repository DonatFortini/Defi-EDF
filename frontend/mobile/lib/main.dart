import 'package:flutter/material.dart';
import 'package:mobile/ui/view/home_view.dart';
import 'package:mobile/ui/view/profile_view.dart';
import 'package:mobile/ui/utils/modal_actions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => MainScreen(),
        '/rental': (context) => Container(),
        '/ecology': (context) => Container(),
        '/disaster': (context) => Container(),
        '/scanner': (context) => Container(),
        '/community': (context) => Container(),
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
    Container(),
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
