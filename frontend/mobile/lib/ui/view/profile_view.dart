import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with actual data fetching logic
    final String name = 'pa';
    final String email = 'test@gmail.com';
    final String imageUrl = 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileHeader(name: name, email: email, imageUrl: imageUrl),
              const SizedBox(height: 20),
              const ProfileOptionsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptionsList extends StatelessWidget {
  const ProfileOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOption(
          icon: Icons.history,
          title: 'Historique',
          onTap: () => Navigator.pushNamed(context, '/history'),
        ),
        ProfileOption(
          icon: Icons.settings,
          title: 'Paramètres',
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
        ProfileOption(
          icon: Icons.logout,
          title: 'Déconnexion',
          onTap: () => Navigator.pushNamed(context, '/logout'),
        ),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String name;
  final String email;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(height: 20),
        Text(name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(email, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
