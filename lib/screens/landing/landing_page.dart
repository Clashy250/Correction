import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(), // Only shows login screen
    );
  }
}
