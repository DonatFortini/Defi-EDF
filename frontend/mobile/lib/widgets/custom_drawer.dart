import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Fleet Car Management',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Available Cars'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Available Cars screen
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Book a Car'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Book a Car screen
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_return),
            title: Text('Return a Car'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Return a Car screen
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Rental History'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Rental History screen
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Report an Issue'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Report an Issue screen
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Profile screen
            },
          ),
        ],
      ),
    );
  }
}
