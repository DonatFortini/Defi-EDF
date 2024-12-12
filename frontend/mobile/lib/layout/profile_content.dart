import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile/header.dart';
import 'package:frontend/widgets/profile/options_list.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              ProfileHeader(
                name: 'John Doe',
                email: 'john.doe@example.com',
                imageUrl: 'https://via.placeholder.com/150',
              ),
              SizedBox(height: 20),
              ProfileOptionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
