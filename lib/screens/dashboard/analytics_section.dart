import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/thingspeak_feed.dart';
import '../../services/thingspeak_service.dart';

class AnalyticsSection extends StatefulWidget {
  const AnalyticsSection({Key? key}) : super(key: key);

  @override
  _AnalyticsSectionState createState() => _AnalyticsSectionState();
}

class _AnalyticsSectionState extends State<AnalyticsSection> {
  late final ThingSpeakService _thingSpeakService;
  late Future<List<ThingSpeakFeed>> _feedsFuture;

  @override
  void initState() {
    super.initState();
    _thingSpeakService = ThingSpeakService(
      channelId: '1634283',
      readApiKey: 'YGW7XIPZGOLTRKT',
    );
    _feedsFuture = _thingSpeakService.fetchFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Level Analytics'),
      ),
      body: FutureBuilder<List<ThingSpeakFeed>>(
        future: _feedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: 0,
                  maxX: snapshot.data!.length.toDouble() - 1,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getChartData(snapshot.data!),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  List<FlSpot> _getChartData(List<ThingSpeakFeed> feeds) {
    return List.generate(feeds.length, (index) {
      return FlSpot(index.toDouble(), feeds[index].fieldValue);
    });
  }
}
