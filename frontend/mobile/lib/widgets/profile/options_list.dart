import 'package:flutter/material.dart';
import 'options.dart';

class ProfileOptionsList extends StatelessWidget {
  const ProfileOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOption(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () {
            // Navigate to settings page
          },
        ),
        ProfileOption(
          icon: Icons.notifications,
          title: 'Notifications',
          onTap: () {
            // Navigate to notifications page
          },
        ),
        ProfileOption(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            // Handle logout logic
          },
        ),
        ProfileOption(
          icon: Icons.lock_clock,
          title: 'Historique',
          onTap: () {
            // Handle logout logic
          },
        ),
      ],
    );
  }
}
