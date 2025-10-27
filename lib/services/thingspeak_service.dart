import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_bin1/models/thingspeak_feed.dart';

class ThingSpeakService {
  static const String _channelId = '1634283';
  static const String _apiKey = 'YGW7XIPZGOLTRKT';
  static const String _baseUrl = 'https://api.thingspeak.com/channels/$_channelId/feeds.json';

  Future<List<ThingSpeakFeed>> fetchChartData() async {
    final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final feeds = data['feeds'] as List;
      return feeds.map((feed) => ThingSpeakFeed.fromJson(feed)).toList();
    } else {
      throw Exception('Failed to load ThingSpeak data');
    }
  }
}
