import 'package:flutter/material.dart';
import 'package:smart_bin1/services/thingspeak_service.dart';
import 'package:smart_bin1/models/thingspeak_feed.dart';

class ViewAllBinsPage extends StatefulWidget {
  const ViewAllBinsPage({super.key});

  @override
  State<ViewAllBinsPage> createState() => _ViewAllBinsPageState();
}

class _ViewAllBinsPageState extends State<ViewAllBinsPage> {
  final ThingSpeakService _thingSpeakService = ThingSpeakService();
  late Future<List<ThingSpeakFeed>> _feedsFuture;

  @override
  void initState() {
    super.initState();
    _feedsFuture = _thingSpeakService.fetchFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Bins'),
      ),
      body: FutureBuilder<List<ThingSpeakFeed>>(
        future: _feedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            final feeds = snapshot.data!;
            return ListView.builder(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                final feed = feeds[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text('Bin ID: \${feed.entryId}'),
                    subtitle: Text('Waste Level: \${feed.fieldValue}'),
                    trailing: Text('Last Updated: \${feed.createdAt}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
