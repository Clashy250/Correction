import 'package:flutter/material.dart';
import '../../models/bin_model.dart';

class BinListSection extends StatelessWidget {
  final List<Bin> bins;

  const BinListSection({super.key, required this.bins});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Available Bins',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: bins.length,
            itemBuilder: (context, index) {
              final bin = bins[index];
              return Card(
                child: ListTile(
                  title: Text(bin.name),
                  subtitle: Text('${bin.fillLevel}% full • ${bin.location}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
