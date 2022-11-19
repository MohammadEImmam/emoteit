import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/leaderboard_models.dart';

class Leaderboard{
  Future<Stats> getStats() async {
    const url = 'https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/leaderboard/stats';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
     final json = jsonDecode(response.body);
     return Stats.fromJson(json);
    } else {
      throw Exception('Failed to retrieve stats from server STATUS CODE : ${response.statusCode}');
    }
  }
}