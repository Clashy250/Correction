import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const Text(
        '© 2025 Smart Bin Inc.',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
