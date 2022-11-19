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

  Future<List<Leaders>> getLeaders() async {
    const url = 'https://us-central1-emoteit-96e60.cloudfunctions.net/emoteit_server/api/leaderboard/top10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
     final json = jsonDecode(response.body) as List;
     final result = json.map((e){
        return Leaders(
          id: e['_id'],
          name: e['name'],
          answerTime: e['totalAnswerTimeMs'],
          email: e['email'],
          time: e['DOB'],
          score: e['score'],
          typeID: e['typeId'],
          pictureURL: e['pictureUrl'],
          uID: e['uid'],
          createdAt: e['createdAt'],
          updatedAt: e['updatedAt'],
        );
     }).toList();
     return result;
    } else {
      throw Exception('Failed to retrieve leaders from server STATUS CODE : ${response.statusCode}');
    }
  }
}