import 'package:flutter/material.dart';
import 'package:mobile/domain/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            const SizedBox(height: 20),
            _buildAppTitle(),
            const SizedBox(height: 40),
            _buildTextField(emailController, 'Email'),
            const SizedBox(height: 20),
            _buildTextField(passwordController, 'Password', obscureText: true),
            const SizedBox(height: 20),
            _buildLoginButton(context, emailController, passwordController),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset('assets/EDF.svg', width: 100, height: 100);
  }

  Widget _buildAppTitle() {
    return const Text(
      'App Title',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;
        try {
          await AuthService().login(email, password);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isAuthenticated', true);
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed('/');
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
          }
        }
      },
      child: const Text('Login'),
    );
  }
}
