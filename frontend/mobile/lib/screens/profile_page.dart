import 'package:flutter/material.dart';
import 'package:frontend/layout/profile_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileContent());
  }
}
