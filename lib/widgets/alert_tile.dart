import 'package:flutter/material.dart';

class AlertTile extends StatelessWidget {
  final String binId;
  final String message;
  final String time;

  const AlertTile({
    super.key,
    required this.binId,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.warning, color: Colors.red),
      title: Text("Bin $binId: $message"),
      subtitle: Text(time),
    );
  }
}
