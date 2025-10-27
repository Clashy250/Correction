import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const QuickActionButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(minimumSize: Size(150, 40)),
    );
  }
}
