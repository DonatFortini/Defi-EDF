import 'package:flutter/material.dart';
import 'package:frontend/core/providers/login_provider.dart';
import 'package:frontend/widgets/profile/header.dart';
import 'package:frontend/widgets/profile/options_list.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfileHeader(
                    name: 'pa',
                    email: 'test@gmail.com',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  const SizedBox(height: 20),
                  const ProfileOptionsList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
