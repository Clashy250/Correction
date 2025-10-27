import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(title, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
