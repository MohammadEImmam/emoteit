import 'dart:convert';

import 'package:http/http.dart' as http;
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

class Stats {
  final int emortionCount;
  final int insightCount;
  final int newUserCount;
  final int newRelationshipCount;
  const Stats({
    required this.emortionCount,
    required this.insightCount,
    required this.newUserCount,
    required this.newRelationshipCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      emortionCount: json['emortionCount'],
      insightCount: json['insightCount'],
      newUserCount: json['newUserCount'],
      newRelationshipCount: json['newRelationshipCount'],
    );
  }
}
Future<Stats> fetchStats() async {
  final response = await http
      .get(Uri.parse('https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/leaderboard/stats'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Stats.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}