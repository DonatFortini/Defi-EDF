import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/community_provider.dart';
import 'package:frontend/layout/community_content.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityProvider(),
      child: Scaffold(
        appBar:
            AppBar(title: const Text('Communauté - Transition Énergétique')),
        body: const CommunityContent(),
      ),
    );
  }
}
