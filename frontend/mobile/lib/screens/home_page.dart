import 'package:flutter/material.dart';
import 'package:frontend/screens/community_page.dart';
import 'package:frontend/screens/ecology_page.dart';
import 'package:frontend/screens/profile_page.dart';
import 'package:frontend/layout/home_content.dart';
import 'package:frontend/layout/modal_content.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  MobileHomePageState createState() => MobileHomePageState();
}

class MobileHomePageState extends State<MobileHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    EcologyPage(),
    Placeholder(),
    CommunityPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showActionModal(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showActionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.3,
        maxChildSize: 0.6,
        expand: false,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: const ModalContent(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Écologie',
          ),
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
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
